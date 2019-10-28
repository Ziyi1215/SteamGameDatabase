Rails.application.routes.draw do

  get 'packages/new'

  get 'language/new'

  get 'publishers/new'

  get 'developers/new'

  get 'games/new'

  root 'pages#home'

  get '/home', to: 'pages#home'

  get 'language', to: 'language#index', as: 'languages'

  resources :games
  resources :developers
  resources :publishers
  resources :language
  resources :packages
end
