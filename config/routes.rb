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

  # Employer 
  scope '/:companyslug', controller: :company, as: :company do
    get '/' => :show
    get '/edit' => :edit
    patch '/' => :update
    resources :opportunities
  end

  # Students
  resources :student, only: [:show, :edit, :update]
  resources :opportunities, only: [:show] do
    resources :applications
  end

  root 'landing#index'
end
