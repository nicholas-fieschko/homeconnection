class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:name, :gender, :birthday, :about, :provider,
                                 :email, :password, :password_confirmation, :zipcode, 
                                 :food,      :food_info, 
                                 :shelter,   :shelter_info, 
                                 :transport, :transport_info, 
                                 :shower,    :shower_info, 
                                 :laundry,   :laundry_info, 
                                 :buddy,     :buddy_info, 
                                 :misc,      :misc_info,
                                 :shelter_accessible, :shelter_pets)
  end

  def account_update_params
    params.require(:user).permit(:name, :gender, :birthday, :about, :provider,
                                 :email, :password, :password_confirmation, 
                                 :current_password, :zipcode, 
                                 :food,      :food_info, 
                                 :shelter,   :shelter_info, 
                                 :transport, :transport_info, 
                                 :shower,    :shower_info, 
                                 :laundry,   :laundry_info, 
                                 :buddy,     :buddy_info, 
                                 :misc,      :misc_info,
                                 :shelter_accessible, :shelter_pets,
                                 :privacy_email, :privacy_location, :privacy_activity, 
                                 :privacy_gender, :privacy_age, :privacy_about, 
                                 :privacy_resources, :privacy_resources_info, 
                                 :privacy_exchanges, :privacy_name )
  end

end
