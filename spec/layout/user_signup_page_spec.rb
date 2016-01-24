require 'rails_helper'

feature "Sign up page" do
  
  describe "Sign-up page has all neccessary fields" do

    before { visit new_user_registration_path }

    it "has an email input field" do
      expect(page).to have_xpath("//input[@name='user[email]']")
    end

    it "has a name input field" do
      expect(page).to have_xpath("//input[@name='user[name]']")
    end

    it "has a gender input field" do
      expect(page).to have_xpath("//input[@name='user[gender]']")
    end

    it "has a birthday input field" do
      expect(page).to have_xpath("//input[@name='user[birthday]']")
    end

    it "has an about-me input field" do
      expect(page).to have_xpath("//textarea[@name='user[about]']")
    end

    it "has an provider-or-seeker input field" do
      expect(page).to have_xpath("//input[@name='user[provider]']")
    end

    it "has password and password confirmation input fields" do
      expect(page).to have_xpath("//input[@name='user[password]']")
      expect(page).to have_xpath("//input[@name='user[password_confirmation]']")
    end

    it "has a submit button" do
      expect(page).to have_xpath("//input[@type='submit']")
    end

  end

end