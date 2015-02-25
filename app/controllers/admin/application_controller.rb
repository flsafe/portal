class Admin::ApplicationController < ApplicationController

  before_action :set_school

  private

  def set_school
    # /admin/schools/:id
    # /admin/schools/:school_id/something/:id
    @school = School.find(params[:school_id] || params[:id])
    return if current_user.role == 'admin'
    redirect_to(admin_school_url(current_user.school), notice: "You don't have permission") unless @school == current_user.school
  end
end