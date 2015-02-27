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
      resources :students, controller: 'users', type: 'Student'
      resources :staff, controller: 'users', type: 'Staff'
      resources :instructor, controller: 'users', type: 'Instructor'
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
