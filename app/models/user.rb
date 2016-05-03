class User < ActiveRecord::Base
  devise :database_authenticatable,   :registerable,
         :recoverable, :rememberable, :trackable,    :validatable,
         :confirmable, :lockable,     :timeoutable
  acts_as_messageable

  has_many :reviews

  geocoded_by      :zipcode
  after_validation :geocode, :set_lonlat, :reverse_geocode, if: -> (user) { user.zipcode.present? and user.zipcode_changed? }

  reverse_geocoded_by :latitude, :longitude do |user, results|
    if geo = results.first
      user.city    = geo.city
      user.state   = geo.state
      user.country = geo.country
    end
  end

  # Methods

  # Returns distance from other user in miles or nil if there is insufficient information.
  def distance_from(other_user)
    begin
      self.lonlat.distance(other_user.lonlat) / 1609.344 # Convert from meters.
    rescue Exception
      nil
    end
  end

  def self.search(params)
    distance_in_meters = params[:distance].to_f * 1609.344
    query_params = {}
    center_user =  params[:user]
    query_params[:food]      = true unless params[:food].nil?
    query_params[:shelter]   = true unless params[:shelter].nil?
    query_params[:transport] = true unless params[:transport].nil?
    query_params[:shower]    = true unless params[:shower].nil?
    query_params[:laundry]   = true unless params[:laundry].nil?
    query_params[:buddy]     = true unless params[:buddy].nil?
    query_params[:misc]      = true unless params[:misc].nil?
    resources_AND_query = User.unscoped.where(query_params) # Make query which requires all resources marked as "true"
    User.where("ST_Distance(lonlat, '#{center_user.lonlat}') < #{distance_in_meters}")
        .where(provider: !center_user.provider? ) # Show user the opposite category of users.
        .where(resources_AND_query.where_values.inject(:or))
        # Convert "AND" query to "ANY" query, to include all users who have at least one of the requested resources
        

  end

  def seeker?
    !self.provider?
  end

  def housing?
    self.shelter?
  end

  def transportation?
    self.transport?
  end

  def pronoun(tense)
    standard_pronouns = { 
      "male" => 
      {"they" => "he",
        "them" => "him", 
        "their" => "his"},
      "female" => 
      {"they" => "she",
        "them" => "her", 
        "their" => "her"} }
    identity = self.gender.downcase
    standard_pronouns.has_key?(identity) ? standard_pronouns[identity][tense] : tense
  end

  def they
    self.pronoun "they"
  end

  def them
    self.pronoun "them"
  end

  def their
    self.pronoun "their"
  end

  def mailboxer_email(object)
    #if pref.likes_email?
    self.email
  end
  def mailboxer_name
    self.name
  end

  private

  def set_lonlat
    self.lonlat = "POINT(#{self.longitude} #{self.latitude})" unless zipcode.nil?
  end

end
