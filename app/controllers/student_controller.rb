class StudentController < ApplicationController
  before_action :ensure_admin_staff_or_student

  def show
    @student = current_user
    @opportunities = Opportunity.all
  end
end