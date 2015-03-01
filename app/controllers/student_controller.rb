class StudentController < ApplicationController
  before_action :ensure_admin_staff_or_student

  def show
    @student = current_user
    @opportunities = Opportunity.includes(:company).order(created_at: :desc).limit(25)
  end
end