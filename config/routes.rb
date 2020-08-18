Rails.application.routes.draw do
  

  root 'welcome#index'

  #Devise routes
  devise_for :users

  devise_scope :user do
    get '/login' => 'devise/sessions#new' # Custom devise path for login
    get '/signup' => 'devise/registrations#new' # Custom devise path for signup
  end

  # REST routes
  resources :posts
  resources :comments

  #Custom routes

  # User key routes - make sure these are always last
  get '/:username', to: 'users#show', as: 'user'
  # get '/:user_slug/posts' # TODO: Update however we want to view posts by user

  # For details on the DSL available within this file, see https://guides.rubyonrils.org/routing.html
end
