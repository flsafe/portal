Rails.application.routes.draw do

  # User login sessions
  controller :sessions do 
    get 'login' => :new 
    post 'login' => :create
    delete 'logout' => :destroy
  end

  namespace :admin do
    root to: 'admin#index'
    resources :schools
    resources :campuses do
      resources :students, controller: 'users', type: 'Student'
      resources :staff, controller: 'users', type: 'Staff'
      resources :instructor, controller: 'users', type: 'Instructor'
    end
    resources :companies do
      resources :employers
    end
  end

  scope 'oauth' do
    get '/github' => 'oauth#callback_github'
    post '/unlink/:account' => 'oauth#unlink', as: :oauth_unlink
  end

  # School staff
  scope 'staff' do
    get '/' => 'staff#home', as: :staff_home
    get '/inbox/profile/:id' => 'staff#inbox_profile', as: :staff_inbox_profile
    get '/inbox/new_auto_follow_up/:id' => 'staff#new_auto_follow_up', as: :staff_new_auto_follow_up
    get '/students' => 'staff#students', as: :staff_students
    get '/students/:id' => 'staff#show_student', as: :staff_student
    get 'students/:id/applications' => 'staff#student_applications', as: :staff_student_applications
    get 'students/:id/recommend' => 'staff#new_recommendation', as: :staff_new_student_recommendation
    post 'students/:id/recommend' => 'staff#create_recommendation', as: :staff_create_student_recommendation
  end

  # Students
  scope '/student' do
    get '/' => 'student#home', as: :student_home 
    get '/profile' => 'student#edit_profile', as: :edit_student_profile
    patch '/profile' => 'student#update_profile', as: :update_student_profile

    get 'applications' => 'student#applications', as: :student_applications
    get 'applications/:id' => 'student#application', as: :student_application
    get 'applications/:id/edit' => 'student#edit_application', as: :edit_application
    patch 'applications/:id' => 'student#update_application', as: :update_application

    get 'opportunity/:id/new' => 'student#new_application', as: :new_application
    get 'opportunity/:id' => 'student#show_opportunity', as: :student_opportunity
    post 'opportunity/:id' => 'student#create_application', as: :create_application
  end

  # Employer 
  scope '/:companyslug', controller: :company, as: :company do
    get '/' => :show
    get '/edit' => :edit
    patch '/' => :update
    resources :opportunities
  end

  # Staff
  resources :opportunities, only: [:show] do
    resources :applications, shallow: :true
  end

  root 'landing#index'
end
