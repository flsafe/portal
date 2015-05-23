class EmployerPortalController < ApplicationController
  before_action :ensure_employer
  before_action :set_company

  private

  def ensure_employer
    redirect_home(current_user) unless current_user.employer?
  end
  
  def set_company
    @company = current_user.company
    redirect_home(current_user) unless @company 
  end
end