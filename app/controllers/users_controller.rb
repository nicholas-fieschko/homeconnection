class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def index
    if signed_in?
      set_default_params
      @users = User.search(params.merge(user: current_user)).where.not(id: current_user.id)
    else 
      redirect_to splash_path
    end
  end

  def edit_resource_profile
    @user = current_user
  end

  def edit_privacy
    @user = current_user
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
      params[:distance]  = 1000 # Default
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
