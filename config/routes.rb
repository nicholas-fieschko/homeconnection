Rails.application.routes.draw do
  
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show, :index]

  root 'pages#home'

end
