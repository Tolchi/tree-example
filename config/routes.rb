TreeExample::Application.routes.draw do
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
  resources :users, :only => [:show, :index]
end
