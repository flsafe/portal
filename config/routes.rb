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

    get '/applications/pending' => 'staff#events', as: :staff_home
    get '/applications/:type' => 'staff#events', as: :staff_applications
    post '/applications/:id/approve' => 'staff#application_action', as: :staff_application_approve, application_action: :approve
    post '/applications/:id/reject' => 'staff#application_action', as: :staff_application_reject, application_action: :reject

    get '/student-notes/:id/application/:application_id' => 'staff#inbox_edit_student_placement_profile', as: :staff_inbox_edit_student_placement_profile

    get '/activity/' => 'staff#activity', as: :staff_activity
    get '/inbox/profile/:id' => 'staff#inbox_profile', as: :staff_inbox_profile
    get '/inbox/new_auto_follow_up/:id' => 'staff#new_auto_follow_up', as: :staff_new_auto_follow_up

    get '/recommendations' => 'staff#recommendations', as: :staff_recomendations
    get '/jobs' => 'staff#opportunities', as: :staff_opportunities
    get '/jobs/:id' => 'staff#opportunity', as: :staff_opportunity
    get '/jobs/:id/applications' => 'staff#opportunity_applications', as: :staff_opportunity_applications
    get '/campuses' => 'staff#campuses', as: :staff_campuses

    get '/team' => 'staff#team', as: :staff_team
    delete '/team/:id' => 'staff#delete_team_member', as: :staff_delete_team_member
    get '/team/new' => 'staff#new_team_member', as: :staff_new_team_member
    get '/team/invites' => 'staff#team_invites', as: :staff_team_invites
    post '/team/invites' => 'staff#create_team_member', as: :staff_create_team_member

    get '/companies' => 'staff#companies', as: :staff_companies
    post '/companies' => 'staff#create_company'
    get '/companies/new' => 'staff#new_company', as: :staff_new_company

    get '/students' => 'staff#students', as: :staff_students
    get '/students/new' => 'staff#new_student', as: :staff_new_student

    post '/students/invites' => 'staff#create_student', as: :staff_create_student
    get '/students/invites' => 'staff#invites', as: :staff_invites
    delete '/students/invites/:id' => 'staff#delete_invite', as: :staff_delete_invite

    get '/students/:id' => 'staff#show_student', as: :staff_student
    get 'students/:id/profile' => 'staff#student_placement_profile', as: :staff_student_placement_profile
    get 'students/:id/profile/:application_id/edit' => 'staff#edit_student_placement_profile', as: :staff_edit_student_placement_profile
    get 'students/profile/:application_id' => 'staff#new_student_placement_event', as: :staff_new_student_placement_event
    post 'students/profile/:application_id' => 'staff#create_student_placement_event', as: :staff_create_student_placement_event
    delete 'students/event/:event_id' => 'staff#destroy_student_placement_event', as: :staff_destroy_student_placement_event
    
    get 'students/:id/recommend' => 'staff#new_recommendation', as: :staff_new_student_recommendation
    post 'students/:id/recommend' => 'staff#create_recommendation', as: :staff_create_student_recommendation

    get 'students/:id/resume' => 'staff#student_resume', as: :staff_student_resume
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
