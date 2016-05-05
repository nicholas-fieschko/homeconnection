Rails.application.routes.draw do
  root 'users#index'
  
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/settings' => "devise/registrations#edit"
  end
  resources :users, only: [:show, :index] do
    resources :reviews, path_names: { new: 'new/:exchange_id' }
  end
  resources :exchanges, path_names: { new: 'new/:target_user_id' }

  get '/welcome' => 'pages#splash', as: 'splash'
  get '/about'   => 'pages#about',  as: 'about'

  # mailbox folder routes
  get "/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "/sent"  => "mailbox#sent",  as: :mailbox_sent
  get "/trash" => "mailbox#trash", as: :mailbox_trash

  # Exchange dashboard route
  get '/dashboard' => 'exchanges#index'

  # Profile routes
  get '/privacy'               => 'users#edit_privacy'
  get '/profile/edit'          => 'users#edit_profile'
  get '/resource_profile/edit' => 'users#edit_resource_profile'
  get '/profile'               => 'users#profile'

  resources :conversations, path_names: { new: 'new/:recipient_id' } do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end


end
