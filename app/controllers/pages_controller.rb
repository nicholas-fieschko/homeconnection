class PagesController < ApplicationController

  def home
    @results_users = User.all
  end

end
