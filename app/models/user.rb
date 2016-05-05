class User < ActiveRecord::Base
  devise :database_authenticatable,   :registerable,
         :recoverable, :rememberable, :trackable,    :validatable,
         :confirmable, :lockable,     :timeoutable
  acts_as_messageable

  has_many :reviews
  has_many :blacklistings

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

  def field_viewable_by?(fieldname, other_user=nil)
    case fieldname
    when :email
      category_id = self.privacy_email
    when :activity
      category_id = self.privacy_activity
    when :location
      category_id = self.privacy_location
    when :resources
      category_id = self.privacy_resources
    when :resources_info
      category_id = self.privacy_resources_info
    when :age
      category_id = self.privacy_age
    when :gender
      category_id = self.privacy_gender
    when :name
      category_id = self.privacy_name
    when :about
      category_id = self.privacy_about
    when :exchanges
      category_id = self.privacy_exchanges
    else
      throw new Exception
    end
     other_user_in_authorization_category? category_id, other_user
  end


  def other_user_in_authorization_category?(category_id,other_user)
    return true if !other_user.nil? && other_user.id == self.id # User can always view self
    case category_id
    when 4 # Public
      true 
    when 3 # Signed in users
      !other_user.nil?
    when 2 # Users in opposite provider/seeker category
      !other_user.nil? &&
        other_user.provider? != self.provider?
    when 1 # Self user has accepted an exchange with other_user
      return false if other_user.nil?
      provider_id = self.provider? ? self.id : other_user.id
      seeker_id   = self.seeker?   ? self.id : other_user.id
      accepted_field = self.provider? ? :p_accepted : :s_accepted
      Exchange.where(provider_id: provider_id, seeker_id: seeker_id, accepted_field => true).any?
    when 0
      other_user.id == self.id
    end
  end

  def exchanges
    Exchange.where(self.provider? ? { provider_id: self.id } : { seeker_id: self.id })
  end

  def self.search(params)
    distance_in_meters = params[:distance].to_f * 1609.344
    or_params = {}
    and_params = {}
    center_user =  params[:user]
    or_params[:food]               = true unless params[:food].nil?
    or_params[:shelter]            = true unless params[:shelter].nil?
    or_params[:transport]          = true unless params[:transport].nil?
    or_params[:shower]             = true unless params[:shower].nil?
    or_params[:laundry]            = true unless params[:laundry].nil?
    or_params[:buddy]              = true unless params[:buddy].nil?
    or_params[:misc]               = true unless params[:misc].nil?
    if or_params[:shelter] 
      and_params[:shelter_accessible] = true unless params[:shelter_accessible].nil?
      and_params[:shelter_pets]       = true unless params[:shelter_pets].nil?
    end
    distance_params = center_user.lonlat.nil? ? {} : "ST_Distance(lonlat, '#{center_user.lonlat}') < #{distance_in_meters}"

    resources_or_query = User.unscoped.where(or_params) # Make query which requires all resources marked as "true"
    User.where(distance_params)
        .where(provider: !center_user.provider? ) # Show user the opposite category of users.
        .where(and_params) # If accessibility / pets are checked they are treated as all required
        .where(resources_or_query.where_values.inject(:or))
        # for other resrouces, include all users who have at least one of the requested resources
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

  def self.default_privacy
    { privacy_email: 0,
      privacy_activity: 2,
      privacy_name: 3,
      privacy_location: 4,
      privacy_gender: 4,
      privacy_age: 4,
      privacy_about: 4,
      privacy_resources: 4,
      privacy_resources_info: 4,
      privacy_exchanges: 4 }
  end

  private

  def set_lonlat
    self.lonlat = "POINT(#{self.longitude} #{self.latitude})" unless zipcode.nil?
  end

end
