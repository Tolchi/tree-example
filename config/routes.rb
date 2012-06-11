TreeExample::Application.routes.draw do
  get "static_pages/categories"
  get "static_pages/home"
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/categories"
  get "static_pages/companies"
  get "static_pages/company"
  get "static_pages/forum"
  get "static_pages/market"
  get "static_pages/tags"

  match "cats" => "static_pages#categories"
  match "coms" => "static_pages#companies"
  match "com" => "static_pages#company"
  match "market" => "static_pages#market"
  match "forum" => "static_pages#forum"
  match "help" => "static_pages#help"
  match "about" => "static_pages#about"
  match "tag" => "static_pages#tag"
  match "contact" => "contact#new", :as => "contact", :via => :get
  match "contact" => "contact#create", :as => "contact", :via => :post

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
