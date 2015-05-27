class Employer::ApplicationsController < EmployerPortalController
  before_action :ensure_opportunity_belongs_to_employer

  def index 
    @applications = @opportunity.applications.includes(:student)
  end

  private

  def ensure_opportunity_belongs_to_employer
    @opportunity = Opportunity.find_by(employer: current_user,
                                       id: params[:opportunity_id])
    redirect_home(current_user) unless @opportunity
  end
end