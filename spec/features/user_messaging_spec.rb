require 'rails_helper'

feature "Messaging" do
  let(:bob)   { create :user, name: "Bob" }
  let(:alice) { create :user, name: "Alice" }

  describe "Exchanging messages" do
    before do 
      login_as(bob, scope: :user) 
      visit user_path(alice)
    end

    it "Bob should see a contact button on Alice's userpage" do
      expect(page).to have_link "Contact", 
                        href: new_conversation_path(alice.id)
    end

    describe "Sending the first message" do
      before do
        click_on "Contact"
        fill_in "conversation_subject", with: "Hello"
        fill_in "conversation_body", with: "Just saying hi"
      end

      it "should be able to successfully send a message through that link" do
        expect{ click_on "Send Message" }.to change{ alice.mailbox.inbox.count }.by 1
      end

      it "Alice should see the message from Bob in her inbox" do
        click_on "Send Message"

        login_as(alice, scope: :user) 
        visit mailbox_inbox_path
        expect(page).to have_text "Bob"
        expect(page).to have_text "Hello"
      end
    end
  end
end