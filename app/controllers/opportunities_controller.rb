class OpportunitiesController < EmployerPortalController 
  layout 'employer'
  before_action :set_company
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]

  # GET /opportunities
  # GET /opportunities.json
  def index
    @opportunities = Opportunity.where(company: @company)
                                .includes(:company)
                                .paginate(page: params[:page], per_page: 10)
  end

  # GET /opportunities/1
  # GET /opportunities/1.json
  def show
    @company = @opportunity.company
  end

  # GET /opportunities/new
  def new
    @opportunity = Opportunity.new
  end

  # GET /opportunities/1/edit
  def edit
  end

  # POST /opportunities
  # POST /opportunities.json
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
        format.html { redirect_to employer_home_url(@company.slug), notice: 'Opportunity was successfully created.' }
        format.json { render :show, status: :created, location: @opportunity }
      else
        format.html { render :new }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opportunities/1
  # PATCH/PUT /opportunities/1.json
  def update
    respond_to do |format|
      if @opportunity.update(opportunity_params)
        format.html { redirect_to employer_home_url(@company.slug), notice: 'Opportunity was successfully updated.' }
        format.json { render :show, status: :ok, location: @opportunity }
      else
        format.html { render :edit }
        format.json { render json: @opportunity.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_opportunity
    @opportunity = Opportunity.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def opportunity_params
    params.require(:opportunity).permit(:title, :description, :skills, :requirements, :city, :state)
  end
end
