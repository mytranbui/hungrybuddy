Rails.application.routes.draw do
  devise_for :users, controllers: {
     sessions: 'users/sessions', registrations: 'users/registrations' 
  }
  root to: "pages#home"
  get "dashboard", to: "pages#dashboard", as: :dashboard
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :foodplaces do
    resources :reviews
  end
  resources :reviews
  
  resources :lists do
    resources :bookmarks, only: [:new, :create]
  end
  resources :bookmarks, only: [:destroy]
  # not sure about the routes
end