class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
  acts_as_messageable

  def seeker?
    !self.provider?
  end

  def food?
    true
  end

  def shower?
    true
  end

  def laundry?
    true
  end

  def housing?
    true
  end

  def transportation?
    true
  end

  def buddy?
    true
  end

  def misc?
    true
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

end
