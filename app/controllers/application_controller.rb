class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include UserHomePage
  include Oauth
  protect_from_forgery with: :exception
  before_action :authorize

  helper_method :current_user
  helper_method :user_home_url
  helper_method :github_scope!

  protected

  def session_redirect=(r)
    session[:session_redirect] = r
  end

  def session_redirect
    session[:session_redirect]
  end

  def session_redirect?
    !!session_redirect
  end

  def redirect_to_session_or(target, opts)
    redirect_to((session_redirect? ? session_redirect : target), opts)
  end

  def ensure_admin
    redirect_home(current_user) unless current_user.admin?
  end

  def ensure_staff
    redirect_home(current_user) unless current_user.staff?
  end

  def ensure_admin_or_staff
      redirect_home(current_user) unless current_user.admin_or_staff?
  end

  def ensure_employer
    redirect_home(current_user) unless current_user.employer?
  end 

  def ensure_admin_staff_or_student
    redirect_home(current_user) unless current_user.admin_or_staff? || current_user.student?
  end

  def current_user
    return @current_user if @current_user
    if session[:user_id]
      user = User.find(session[:user_id]) 
      @current_user = user.becomes(user.type.constantize)
    end
    @current_user
  end

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
