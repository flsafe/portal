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
    resources :companies do
      resources :employers
    end
  end

  # Under an employer scope 
  scope '/:company-slug', controller: :companies do
    get '/' => :show
    get '/edit' => :edit
    post '/' => :update
    resources :opportunities
  end

  resources :applications

  root 'landing#index'
end
