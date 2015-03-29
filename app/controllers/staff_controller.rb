class StaffController < ApplicationController

  before_action :ensure_staff

  def home
  end

  def students
    @students = Student
                  .joins(:school)
                  .includes(:school)
                  .where(school: current_user.school)
                  .paginate(page: params[:page], per_page: 20)
  end

end