Rails.application.routes.draw do
  root 'welcome#index'

  resources :posts
  devise_for :users

  devise_scope :user do
    get '/login' => 'devise/sessions#new' # Custom devise path for login
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
