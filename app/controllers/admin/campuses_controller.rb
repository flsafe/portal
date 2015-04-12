class Admin::CampusesController < Admin::ApplicationController

  skip_before_action :ensure_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_admin_or_staff, only: [:new, :create, :edit, :update, :destroy]

  def index
    @campuses = Campus.order('name').all
  end

  def show
    @campus = Campus.find(params[:id])
  end

  def new
    @campus = Campus.new
  end

  def edit
    @campus = Campus.find(params[:id])
  end

  def create
    @campus = Campus.new(campus_params)

    respond_to do |format|
      if @campus.save
        format.html { redirect_to_session_or [:admin, @campus], notice: 'Campus was successfully created.' }
        format.json { render :show, status: :created, location: @campus }
      else
        format.html { render :new }
        format.json { render json: @campus.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @campus = Campus.find(params[:id])
    respond_to do |format|
      if @campus.update(campus_params)
        format.html { redirect_to_session_or [:admin, @campus], notice: 'Campus was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @campus = Campus.find(params[:id])
    @campus.destroy
    respond_to do |format|
      format.html { redirect_to_session_or admin_campus_url, notice: 'Campus was successfully destroyed.' }
    end
  end

  private

  def campus_params
    params.require(:campus).permit(:name, :phone, :custom_domain, :website, :address1, :address2, :city, :state, :zip, :school_id)
  end

  def ensure_admin_or_staff
    current_user.admin_or_staff?
  end
end
