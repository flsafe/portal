require 'redcarpet'

class StudentController < ApplicationController
  before_action :ensure_admin_staff_or_student
  before_action :set_student

  def show
    @companies = Company.includes(:opportunities).order(created_at: :desc).limit(25)
  end

  def applications
    @applications = @student.applications.includes(opportunity: [:company]).limit(25)
  end

  def application
    @application = Application.find(params[:id])
    redirect_home(current_user) unless @student.applications.include?(@application)
  end

  def opportunity
    @md = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @opportunity = Opportunity.find(params[:id])
  end

  private

  def set_student
    @student = Student.find(params[:student_id] || params[:id])
    return if current_user.admin_or_staff?
    redirect_home(current_user) unless @student == current_user
  end
end