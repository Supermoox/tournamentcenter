Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :teams
  resources :pairs 
  resources :pages
  resources :robins
  resources :swits
  resources :eliminations
  resources :my_tournaments
  resources :tournaments do
 		resources :rounds, execpt: [:show, :index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
end
