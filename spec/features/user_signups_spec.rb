require 'rails_helper'

feature "Sign up" do

  before { visit new_user_registration_path }

  let(:new_user) { build(:user) }

  describe "page" do
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

  describe "account creation" do
    before do
      fill_in "Email", with: new_user.email
      fill_in "Name", with: new_user.name
      fill_in "Gender", with: new_user.gender
      fill_in "Birthday", with: new_user.birthday
      fill_in "About", with: new_user.about
      check "Provider" if new_user.provider
      fill_in "Password", with: new_user.password
      fill_in "Password confirmation", with: new_user.password
    end

    context "with valid credentials" do

      it "creates a new user" do
        expect { click_button "Sign up" }.to change { User.count }.by 1
      end

    end

    
  end

end
