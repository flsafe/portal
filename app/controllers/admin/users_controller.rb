class Admin::UsersController < Admin::ApplicationController
  before_action :set_school
  before_action :set_user

  def index
    @staffers = Staffer.where(school: @school)
  end

  def show
  end

  def new
    @staff = Staffer.new
  end

  def edit
    @staff = Staffer.find(params[:id])
  end

  def create
    @staff = Staffer.new(staff_params)
    @staff.school = @school

    respond_to do |format|
      if @staff.save()
        format.html { redirect_to admin_school_staff_url(@school), notice: 'Staffer was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      @staff.attributes = staff_params
      if @staff.save(validate: false)
        format.html { redirect_to admin_school_staff_url(@school), notice: 'Staffer was successfully updated.' }
        format.json { render :show, status: :ok, location: @staff }
      else
        format.html { render :edit }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to admin_school_staff_url(@school), notice: 'Staffer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_user
    return if params[:id].nil?
    @staff = Staffer.find(params[:id])
  end

  def staff_params
    params.require('staffer').permit(:email, :password, :password_confirmation, :avatar,  :first_name, :last_name, :phone, :bio, :address1, :city, :state, :zip)
  end
end
