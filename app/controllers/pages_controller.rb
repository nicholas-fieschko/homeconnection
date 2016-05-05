class PagesController < ApplicationController

  def splash
    redirect_to root_path if signed_in?
  end

  def about
  end

end