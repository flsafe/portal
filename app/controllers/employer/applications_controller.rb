class Employer::ApplicationsController < EmployerPortalController
  before_action :ensure_opportunity_belongs_to_employer

  def index 
    @applications = @opportunity.applications
                                .includes(:student)
                                .paginate(page: params[:page], per_page: 10)
    @recommendations = ApplicationRecommendation.where(application: @applications)
  end

  def show
    @application = Application.includes(:student)
                              .find_by(opportunity: @opportunity, id: params[:id])
    @recommendations = ApplicationRecommendation.includes(:staffer)
                                                .where(application: @application)
  end

  private

  def ensure_opportunity_belongs_to_employer
    @opportunity = Opportunity.find_by(employer: current_user,
                                       id: params[:opportunity_id])
    redirect_home(current_user) unless @opportunity
  end
end