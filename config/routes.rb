Rails.application.routes.draw do

  # User login sessions
  controller :sessions do 
    get 'login' => :new 
    post 'login' => :create
    delete 'logout' => :destroy
  end

  # Invites
  get '/invite/:token' => 'invite#claim', as: :claim_invite

  namespace :admin do
    root to: 'admin#index'
    resources :schools do
      resources :staff, controller: 'users', type: 'Staffer'
    end
    resources :campuses
    resources :companies
    resources :employers
  end

  scope 'oauth' do
    get '/github' => 'oauth#callback_github'
    post '/unlink/:account' => 'oauth#unlink', as: :oauth_unlink
  end

  # School staff
  scope 'staff' do
    get '/' => 'staff#dashboard', as: :staff_dashboard

    get '/profile' => 'staff#edit_profile', as: :edit_staffer_profile
    patch '/profile' => 'staff#update_profile'

    get '/messages/' => 'staff#messages', as: :staff_messages
    get '/tasks/' => 'staff#tasks', as: :staff_tasks
    get '/activity/' => 'staff#activity', as: :staff_activity
    get '/inbox/profile/:id' => 'staff#inbox_profile', as: :staff_inbox_profile
    get '/inbox/new_auto_follow_up/:id' => 'staff#new_auto_follow_up', as: :staff_new_auto_follow_up

    get '/recommendations' => 'staff#recommendations', as: :staff_recomendations
    get '/jobs' => 'staff#opportunities', as: :staff_opportunities
    get '/campuses' => 'staff#campuses', as: :staff_campuses

    get '/team' => 'staff#team', as: :staff_team
    delete '/team/:id' => 'staff#delete_team_member', as: :staff_delete_team_member
    get '/team/new' => 'staff#new_team_member', as: :staff_new_team_member
    get '/team/invites' => 'staff#staff_invites', as: :staff_team_invites
    post '/team/invites' => 'staff#create_team_member', as: :staff_create_team_member

    get '/partners' => 'staff#partners', as: :staff_partners
    post '/partners' => 'staff#create_partner'
    get '/partners/new' => 'staff#new_partner', as: :staff_new_partner

    get '/companies' => 'staff#companies', as: :staff_companies
    post '/companies' => 'staff#create_company'
    get '/companies/new' => 'staff#new_company', as: :staff_new_company

    get '/students' => 'staff#students', as: :staff_students
    post '/students' => 'staff#students'
    get '/students/new' => 'staff#new_student', as: :staff_new_student

    post '/students/invites' => 'staff#create_student', as: :staff_create_student
    get '/students/invites' => 'staff#invites', as: :staff_invites
    delete '/students/invites/:id' => 'staff#delete_invite', as: :staff_delete_invite

    get '/students/:id' => 'staff#show_student', as: :staff_student
    get 'students/:id/profile' => 'staff#student_placement_profile', as: :staff_student_placement_profile
    get 'students/:id/profile/edit' => 'staff#edit_student_placement_profile', as: :staff_edit_student_placement_profile
    patch 'students/:id/profile' => 'staff#student_placement_profile', as: :staff_update_student_placement_profile
    
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
  scope '/:companyslug', controller: :company do
    get '/' => :show, as: :company
    patch '/' => :update, as: :company_update
    get '/edit' => :edit, as: :company_edit

    get '/profile' => :edit_employer_profile, as: :edit_employer_profile
    patch '/profile' => :update_employer_profile, as: :update_employer_profile
    resources :opportunities
  end

  resources :opportunities, only: [:show] do
    resources :applications, shallow: :true
  end

  root 'landing#index'
end
