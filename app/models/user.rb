# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :text
#  gender                 :text
#  birthday               :date
#  about                  :text
#  provider               :boolean
#

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable


  def seeker?
    !self.provider?
  end

  def food?
    true
    # self.food_resource[:currently_offered]
  end

  def shower?
    true
    # self.shower_resource[:currently_offered]
  end

  def laundry?
    true
    # self.laundry_resource[:currently_offered]
  end

  def housing?
    true
    # self.housing_resource[:currently_offered]
  end

  def transportation?
    true
    # self.transportation_resource[:currently_offered]
  end

  def buddy?
    true
    # self.buddy_resource[:currently_offered]
  end

  def misc?
    true
    # self.misc_resource && self.misc_resource[:currently_offered]
  end
end
