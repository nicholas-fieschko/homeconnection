require 'rails_helper'

feature "Sign up" do

  before { visit new_user_registration_path }

  describe "registration page" do
    it "has an email input field" do
      expect(page).to have_field "Email"
    end

    it "has a name input field" do
      expect(page).to have_field "Name"
    end

    it "has a gender input field" do
      expect(page).to have_field "Gender"
    end

    it "has a birthday input field" do
      expect(page).to have_field "Birthday"
    end

    it "has an about-me input field" do
      expect(page).to have_field "About"
    end

    it "has an provider-or-seeker input field" do
      expect(page).to have_field "Provider"
    end

    it "has password and password confirmation input fields" do
      expect(page).to have_field "Password"
      expect(page).to have_field "Password confirmation"
    end

    it "has a submit button" do
      expect(page).to have_button "Sign up"
    end
  end


end
