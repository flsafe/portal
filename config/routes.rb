Rails.application.routes.draw do

  # User login sessions
  get 'admin', to: 'admin#index'
  controller :sessions do 
    get 'login' => :new 
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :applications

  resources :opportunities

  resources :companies

  resources :users

  resources :schools

  root 'landing#index'
end
