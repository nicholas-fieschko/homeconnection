require 'rails_helper'

feature "Exchange system" do
  let(:provider) { create :user, provider: true  }
  let(:seeker)   { create :user, provider: false }

  def current_exchange 
    Exchange.find_by(provider_id: provider.id, seeker_id: seeker.id)
  end

  describe "processs of making a help offer" do
    before do
      login_as(provider, scope: :user) 
      visit user_path(seeker)
    end
    it "provider sees offer button on seeker's userpage" do
      expect(page).to have_link "Offer", href: new_exchange_path(target_user_id: seeker.id)
    end
    describe "first user offer confirmation" do
      before { click_link "Offer" }
      it "clicking the offer button brings user to a confirmation page" do
        expect(page).to have_button "Offer"
      end

      it "confirming creates a new exchange with correct state" do
        expect { click_button "Offer" }.to change { Exchange.count }.by 1
        expect(current_exchange.p_accepted).to be true
        expect(current_exchange.s_accepted).to be false
        expect(current_exchange.p_finished).to be false
        expect(current_exchange.s_finished).to be false
      end

      it "after confirming, first user must wait for other user to respond before able to proceed" do
        click_button "Offer"
        visit edit_exchange_path(current_exchange)
        expect(page).not_to have_button "Accept"
        expect(page).to have_text "Waiting"
      end

      describe "second user confirmation process" do
        before do 
          click_button "Offer" # Provider makes offer
          login_as seeker, scope: :user
          visit exchanges_path
        end 

        it "seeker sees offer on dashboard" do
          expect(page).to have_text provider.name
        end

        describe "accepting the offer" do
          before do
            visit edit_exchange_path(current_exchange)
          end

          it "user sees a button to accept the offer on its confirmation page" do
            expect(page).to have_button "Accept"
          end

          it "clicking the accept button updates the exchange to the correct state" do
            click_button "Accept"
            expect(current_exchange.p_accepted).to be true
            expect(current_exchange.s_accepted).to be true
            expect(current_exchange.p_finished).to be false
            expect(current_exchange.s_finished).to be false
          end

          describe "declining the offer" do
            it "user sees a button to decline the offer on its confirmation page" do
              expect(page).to have_link "Decline"
            end

            it "clicking the link deletes the exchange" do
              expect{ click_link "Decline" }.to change{ Exchange.count }.by -1
            end

            it "notifies the other user the exchange was declined" do
              expect{ click_link "Decline" }.to change{ provider.mailbox.inbox.count }.by 1
            end
          end

          context "once both users have accepted the exchange" do
            before do
              click_button "Accept" # Second user accepts exchange
              visit edit_exchange_path(current_exchange)
            end 
            
            describe "process to confirm exchange occurred - first user" do
              it "seeker sees a button to accept the offer on its page" do
                expect(page).to have_button "Confirm"
              end

              it "clicking the accept button updates the exchange to the correct state" do
                click_button "Confirm"
                expect(current_exchange.p_accepted).to be true
                expect(current_exchange.s_accepted).to be true
                expect(current_exchange.p_finished).to be false
                expect(current_exchange.s_finished).to be true
              end

              describe "cancelling the exchange" do
                it "user sees a button to cancel the offer on its confirmation page" do
                  expect(page).to have_link "Cancel"
                end

                it "clicking the link deletes the exchange" do
                  expect{ click_link "Cancel" }.to change{ Exchange.count }.by -1
                end

                it "notifies the other user the exchange was cancelled" do
                  expect{ click_link "Cancel" }.to change{ provider.mailbox.inbox.count }.by 1
                end
              end

              describe "process to confirm exchange occurred - second user" do
                before do
                  click_button "Confirm"
                  login_as provider, scope: :user
                  visit edit_exchange_path(current_exchange)
                end

                it "provider sees a button to accept the offer on its page" do
                  expect(page).to have_button "Confirm"
                end

                it "clicking the accept button updates the exchange to the correct state" do
                  click_button "Confirm"
                  expect(current_exchange.p_accepted).to be true
                  expect(current_exchange.s_accepted).to be true
                  expect(current_exchange.p_finished).to be true
                  expect(current_exchange.s_finished).to be true
                  expect(current_exchange.complete?).to  be true
                end

                context "once both users have confirmed exchange occurred" do
                  before do
                    click_button "Confirm"
                    visit edit_exchange_path(current_exchange)
                  end
                  
                  it "both users see that exchange is completed" do
                    expect(page).to have_text "complete"
                    login_as seeker, scope: :user
                    visit edit_exchange_path(current_exchange)
                    expect(page).to have_text "complete"
                  end

                  it "the user is recommended to review their exchange partner" do
                    expect(page).to have_text "review"
                  end

                  it "there is no option to delete the exchange after completion" do
                    expect(page).not_to have_text /cancel/i
                    expect(page).not_to have_text /decline/i
                  end
                end
              end
            end




          end
        end
      end
    end
  end
end