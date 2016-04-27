require 'rails_helper'

feature "User profile" do
  before { visit user_path(user) }
  let(:user) { create :user }

  describe "the page" do
    it("has the user's name"){ expect(page).to have_text user.name }
    it "has the user's provider or seeker status" do
      user = create :user, provider: true
      visit user_path(user)
      expect(page).to have_text "provider"

      user = create :user, provider: false
      visit user_path(user)
      expect(page).not_to have_text "provider"
    end
  end


end