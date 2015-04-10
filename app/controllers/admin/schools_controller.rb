class Admin::SchoolsController < Admin::ApplicationController

  before_action :ensure_admin

  def index
    @schools = School.order('name').all
  end

  def show
    @school = School.find(params[:id])
  end

  def new
    @school = School.new
  end

  def edit
    @school = School.find(params[:id])
  end

  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to [:admin, @school], notice: 'School was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @school = School.find(params[:id])
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to [:admin, @school], notice: 'School was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @school = School.find(params[:id])
    @school.destroy
    respond_to do |format|
      format.html { redirect_to admin_schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def school_params
    params.require(:school).permit(:name, :phone, :custom_domain, :website, :address1, :address2, :city, :state, :zip)
  end
end
