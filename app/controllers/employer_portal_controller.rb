class EmployerPortalController < ApplicationController
  before_action :set_company
  
  def set_company
    @company = current_user.company
    redirect_home(current_user) unless @company 
  end
end