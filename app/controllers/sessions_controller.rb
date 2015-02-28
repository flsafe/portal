class SessionsController < ApplicationController
  include UserHomePage
  skip_before_action :authorize
  
  def new
    if session[:user_id]
      user = User.find(session[:user_id])
      redirect_home user
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_home user
    else
      redirect_to login_url, alert: "Invalid email or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
