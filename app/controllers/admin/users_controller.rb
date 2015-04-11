class Admin::UsersController < Admin::ApplicationController
  before_action :set_school
  before_action :set_user

  def index
    @staffers = Staff.where(school: @school)
  end

  def show
  end

  def new
    @staff = Staff.new
  end

  def edit
    @staff = Staff.find(params[:id])
  end

  def create
    @staff = Staff.new(staff_params)
    @staff.school = @school

    respond_to do |format|
      if @staff.save()
        format.html { redirect_to admin_school_staffers_url(@school), notice: 'Staff was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      @staff.attributes = staff_params
      if @staff.save(validate: false)
        format.html { redirect_to admin_school_staffers_url(@school), notice: 'Staff was successfully updated.' }
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
      format.html { redirect_to admin_school_staffers_url(@school), notice: 'Staff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_school
    @school = School.find(params[:school_id])
  end

  def set_user
    return if params[:id].nil?
    @staff = Staff.find(params[:id])
  end

  def staff_params
    params.require('staff').permit(:email, :password, :password_confirmation, :avatar,  :first_name, :last_name, :phone, :bio, :address1, :city, :state, :zip)
  end
end
