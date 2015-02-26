class Admin::SchoolsController < Admin::ApplicationController

  skip_before_action :set_school, only: [:index]

  # GET /schools
  # GET /schools.json
  def index
    @schools = School.order('name').all
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    @school = School.find(params[:id])
    @users = @school.users.all
  end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to [:admin, @school], notice: 'School was successfully created.' }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to [:admin, @school], notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to admin_schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_school
    @school = School.find(params[:id])
    return if current_user.role == 'admin'
    redirect_to(admin_school_url(current_user.school)) unless @school == current_user.school
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def school_params
    params.require(:school).permit(:name, :phone, :custom_domain, :website, :address1, :address2, :city, :state, :zip)
  end
end
