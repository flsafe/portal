Rails.application.routes.draw do

  # User login sessions
  controller :sessions do 
    get 'login' => :new 
    post 'login' => :create
    delete 'logout' => :destroy

  end

  namespace :admin do
    root to: 'admin#index'
    resources :schools do
      resources :users
    end
  end

  resources :applications

  resources :opportunities

  resources :companies

  root 'landing#index'
end
