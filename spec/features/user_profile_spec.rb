require 'rails_helper'

feature "User profile" do
  let(:user) { create :user }
  before do 
    login_as(user, scope: :user) 
    visit user_path(user)
  end

  describe "the page" do
    it("has the user's name"){ expect(page).to have_text user.name }
    it "has the user's provider or seeker status" do
      user = create :user, provider: true
      visit user_path(user)
      expect(page).to have_text "Able to provide"

      user = create :user, provider: false
      visit user_path(user)
      expect(page).not_to have_text "Able to provide"
    end
  end


end