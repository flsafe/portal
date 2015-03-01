class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include UserHomePage
  protect_from_forgery with: :exception
  before_action :authorize

  helper_method :current_user

  protected

  def ensure_admin
    redirect_home(current_user) unless current_user.admin?
  end

  def ensure_admin_or_staff
      redirect_home(current_user) unless current_user.admin_or_staff?
  end

  def ensure_admin_staff_or_employer
    redirect_home(current_user) unless current_user.admin_or_staff? || current_user.employer?
  end 

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end  
end
