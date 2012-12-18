SocialQuiz::Application.routes.draw do

  root to: 'pages#home'

  match '/about',   to: 'pages#about'
  match '/help',    to: 'pages#help'
  match '/signup', 	to: 'users#new'
end
