class Admin::ApplicationController < ApplicationController
  include UserHomePage

  before_action :ensure_admin_or_staff

  private

  def ensure_admin
    redirect_home(current_user) unless current_user.admin?
  end

  def ensure_admin_or_staff
      redirect_home(current_user) unless current_user.admin_or_staff?
  end
end