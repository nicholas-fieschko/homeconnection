require 'rails_helper'

feature "User profile" do
  before { visit user_path(user) }
  let(:user) { create :user }

  describe "the page" do
    it("has the user's name"){ expect(page).to have_text user.name }
  end


end