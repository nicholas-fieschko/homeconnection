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
      fill_in "Password", with: new_user.password
      fill_in "Password confirmation", with: new_user.password
    end

    context "with valid credentials" do
      it "creates a new user" do
        expect { click_button "Sign up" }.to change { User.count }.by 1
      end
    end

    context "with invalid credentials" do
      it "does not create a new user" do
        fill_in "Email", with: ""
        expect { click_button "Sign up" }.not_to change { User.count }
      end

      context "with a single invalid field" do
        before do 
          fill_in "Email", with: ""
          click_button "Sign up"
        end

        it "displays an error message" do
          expect(page).to have_selector ".error"
        end

        it "reports the exact invalid field" do
          within(".error") do
            expect(page).to have_text /email/i
          end         
        end
      end

      context "with multiple invalid fields" do
        it "reports all invalid fields" do
          fill_in "Email", with: ""
          fill_in "Password confirmation", with: ""
          click_button "Sign up"

          within(".error") do
            expect(page).to have_text /email/i
            expect(page).to have_text /password/i
          end         
        end
      end
    end
  end
end
