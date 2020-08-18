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
  get '/admin', to: 'admin#index', as: 'admin'
  
  resources :posts do 
    member do 
      put "like", to: "posts#liked_by_user"
      put "dislike", to: "posts#disliked_by_user"
    end 
  end
  # User key routes - make sure these are always last
  get '/:username', to: 'users#show', as: 'user'
  get '/:username/edit', to: 'users#edit', as: 'edit_user'
  patch '/:user_id', to: 'users#update', as: 'update_user'

  # For details on the DSL available within this file, see https://guides.rubyonrils.org/routing.html
end
