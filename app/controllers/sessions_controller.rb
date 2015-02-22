class SessionsController < ApplicationController
  def new
    if session[:user_id]
      user = User.find(session[:user_id])
      redirect_to_role user
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to_role user
    else
      redirect_to login_url, alert: "Invalid email or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def redirect_to_role(user)
    case
    when user.role == 'admin'
      redirect_to admin_url
    else
      raise "Unknown role #{user.role}"
    end
  end
end
