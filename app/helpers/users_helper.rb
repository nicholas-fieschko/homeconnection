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

module UsersHelper

  def location_string(user)
    [user.city, user.state, user.country].reject(&:blank?).join(', ')
  end

  def resources_string(user)
    resources = []
    resources << "food"           if user.food?
    resources << "housing"        if user.shelter?
    resources << "transportation" if user.transport?
    resources << "shower"         if user.shower?
    resources << "laundry"        if user.laundry?
    resources << "buddy system"   if user.buddy?
    resources << "other"          if user.misc?
    resources.join(', ')
  end
end
