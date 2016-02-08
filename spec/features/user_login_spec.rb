require 'rails_helper'

feature "Logging in" do
  before { visit new_user_session_path }
  
  describe "the page" do
    it "has an email field" do
      expect(page).to have_field "Email"
    end

    it "has a password field" do
      expect(page).to have_field "Password"
    end
  end

  describe "the login process" do

    let(:user) { create :user, password: "password123" }

    context "with valid credentials" do
      it "successfully logs in" do
        fill_in "Email", with: user.email
        fill_in "Password", with: "password123"
        click_button "Log in"

        expect(page).to have_text /logged in/i
      end
    end

    context "with invalid credentials" do
      before do
        fill_in "Email", with: user.email
        fill_in "Password", with: "foobar"
        click_button "Log in"
      end

      it "does not successfully log in" do
        expect(page).not_to have_text /logged in/i
      end

      it "displays the login form again" do
        expect(page).to have_field "Email"
        expect(page).to have_field "Password"
      end

      it "displays an error about invalid credentials" do
        expect(page).to have_text /invalid/i
      end
    end
  end
end