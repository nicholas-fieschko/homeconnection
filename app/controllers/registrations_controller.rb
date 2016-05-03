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
                                 :shelter_accessible, :shelter_pets)
  end

end
