class Admin::EmployersController < Admin::ApplicationController
  before_action :set_company
  before_action :set_user

  # GET /users
  # GET /users.json
  def index
    @employers = Employer.where(company: @company)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @employer = Employer.new
  end

  # GET /users/1/edit
  def edit
    @employer = Employer.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @employer = Employer.new(user_params)
    @employer.company = @company

    respond_to do |format|
      if @employer.save
        format.html { redirect_to admin_company_employers_url(@company), notice: 'Employer was successfully created.' }
        format.json { render :show, status: :created, location: @employer }
      else
        format.html { render :new }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @employer.update(user_params)
        format.html { redirect_to admin_company_employers_url(@company), notice: 'Employer was successfully updated.' }
        format.json { render :show, status: :ok, location: @employer }
      else
        format.html { render :edit }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @employer.destroy
    respond_to do |format|
      format.html { redirect_to admin_company_employers_url(@company), notice: 'Employer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_user
    return if params[:id].nil?
    @employer = Employer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:employer).permit(:email, :first_name, :last_name, :bio, :address1, :address2, :password, :password_confirmation)
  end
end
