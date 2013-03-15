# -*- encoding : utf-8 -*-
TreeExample::Application.routes.draw do

  get 'companies/page/:page', to: 'companies#index'
  get "static_pages/help"
  get "static_pages/about"
  get "static_pages/forum"
  get "static_pages/market"
  get "static_pages/tags"

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
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  #resources :users, :only => [:show, :index]
end
