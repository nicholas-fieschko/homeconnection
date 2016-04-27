Rails.application.routes.draw do
  
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show, :index]

  root 'pages#home'

  # mailbox folder routes
  get "/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "/sent" => "mailbox#sent", as: :mailbox_sent
  get "/trash" => "mailbox#trash", as: :mailbox_trash

  resources :conversations, path_names: { new: 'new/:recipient_id' } do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end


end
