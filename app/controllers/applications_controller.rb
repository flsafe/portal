class ApplicationsController < ApplicationController
  before_action :set_opportunity, except: [:show, :edit, :update]
  before_action :set_application, except: [:index, :new, :create] 

  # GET /applications
  # GET /applications.json
  def index
    @applications = @opportunity.applications
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    if existing_app = Application.find_by(opportunity_id: @opportunity.id, user_id: current_user.id)
      redirect_to application_url(existing_app, notice: "You've already applied!")
      return
    end
    @application = Application.new
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = @opportunity.applications.build(application_params) 
    @application.user = current_user

    respond_to do |format|
      if @application.save
        format.html { redirect_to student_url(current_user), notice: 'Application was successfully created.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to student_url(current_user), notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_opportunity
    @opportunity = Opportunity.find(params[:opportunity_id])
    return unless current_user.admin_or_staff?
    redirect_home current_user unless @opportunity.company == current_user.company 
  end

  def set_application
    @application = Application.find(params[:id])
    if current_user.student?
      redirect_home current_user unless @application.user == current_user
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def application_params
    params.require(:application).permit(:cover_letter, :resume)
  end
end
