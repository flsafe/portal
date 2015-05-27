class Employer::OpportunitiesController < EmployerPortalController 
  before_action :set_company
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]

  def index
    @opportunities = Opportunity.where(employer: current_user,
                                       company: @company)
                                .includes(:company)
                                .order(created_at: :desc)
                                .paginate(page: params[:page], per_page: 10)
  end

  def show
    @company = @opportunity.company
  end

  def new
    @opportunity = Opportunity.new
  end

  def edit
  end

  def create
    @opportunity = @company.opportunities.build(opportunity_params)
    @opportunity.employer = current_user
    respond_to do |format|
      if @opportunity.save
        msgs = current_user.schools.map do |school|
          {employer: current_user,
           school: school,
           opportunity: @opportunity}
        end
        OpportunityMessage.create!(msgs)
        format.html { redirect_to employer_opportunities_url, notice: 'Opportunity was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @opportunity.update(opportunity_params)
        format.html { redirect_to employer_opportunities_url, notice: 'Opportunity was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_opportunity
    @opportunity = Opportunity.find(params[:id])
  end

  def opportunity_params
    params.require(:opportunity).permit(:title, :description, :skills, :requirements, :city, :state)
  end
end
