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


  def mailboxer_email(object)
    #if pref.likes_email?
    self.email
  end
  def mailboxer_name
    self.name
  end

end
