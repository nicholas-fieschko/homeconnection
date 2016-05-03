class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def index
    set_default_params
    @users = User.search(params.merge(user: current_user)).where.not(id: current_user.id)
  end

  def edit_profile
    @user = current_user
  end

  def profile
    redirect_to user_path(current_user)
  end

  private

  def set_default_params
    if params[:distance].nil? #First visit to page
      params[:distance]  = 100 # Default
      params[:food]      = "1" if current_user.food?
      params[:shelter]   = "1" if current_user.shelter?
      params[:transport] = "1" if current_user.transport?
      params[:shower]    = "1" if current_user.shower?
      params[:laundry]   = "1" if current_user.laundry?
      params[:buddy]     = "1" if current_user.buddy?
      params[:misc]      = "1" if current_user.misc?
    end
  end

end
