Rails.application.routes.draw do
  
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show, :index] do
    resources :reviews
  end
  resources :exchanges, path_names: { new: 'new/:target_user_id' }

  root 'pages#home'

  # mailbox folder routes
  get "/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "/sent" => "mailbox#sent", as: :mailbox_sent
  get "/trash" => "mailbox#trash", as: :mailbox_trash

  # Exchange dashboard route
  get '/dashboard' => 'exchanges#index'

  # Profile routes
  get '/profile/edit' => 'users#edit_profile'
  get '/profile' => 'users#profile'

  resources :conversations, path_names: { new: 'new/:recipient_id' } do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end


end
