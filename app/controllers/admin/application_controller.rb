class Admin::ApplicationController < ApplicationController
  include UserHomePage

  before_action :ensure_admin_or_staff

  private

  def ensure_admin
    redirect_to_role(current_user) if current_user.type != "Admin"
  end

  def ensure_admin_or_staff
    unless ["Admin", "Staff", "Instructor"].include?(current_user.type)
      redirect_to_role(current_user)
    end
  end
end