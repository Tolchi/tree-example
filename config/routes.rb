TreeExample::Application.routes.draw do
  get "static_pages/categories"

  get "static_pages/home"

  get "static_pages/help"

  get "static_pages/about"

  get "static_pages/contact"

  get "static_pages/categories"

  match "cats" => "static_pages#categories"
  match "help" => "static_pages#help"
  match "contact" => "static_pages#contact"
  match "about" => "static_pages#about"

  resources :companies

  resources :categories do
    collection do
      get :manage
      post :rebuild
    end
  end

  authenticated :user do
    root :to => 'static_pages#home'
  end
  root :to => "static_pages#home"
  devise_for :users
  resources :users, :only => [:show, :index]
end
