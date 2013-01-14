SocialQuiz::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :users, only: [:show, :new, :create, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'pages#home'

  match '/about',   to: 'pages#about'
  match '/signup', 	to: 'users#new'
  match '/signin', 	to: 'sessions#new'
  match '/signout',	to: 'sessions#destroy', via: :delete
end
