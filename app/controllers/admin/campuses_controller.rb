class Admin::CampusesController < Admin::ApplicationController

  before_action :ensure_admin

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
  end

  def create
    @campus = Campus.new(campus_params)

    respond_to do |format|
      if @campus.save
        format.html { redirect_to [:admin, @campus], notice: 'Campus was successfully created.' }
        format.json { render :show, status: :created, location: @campus }
      else
        format.html { render :new }
        format.json { render json: @campus.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @campus.update(campus_params)
        format.html { redirect_to [:admin, @campus], notice: 'Campus was successfully updated.' }
        format.json { render :show, status: :ok, location: @campus }
      else
        format.html { render :edit }
        format.json { render json: @campus.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @campus.destroy
    respond_to do |format|
      format.html { redirect_to admin_campuss_url, notice: 'Campus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def campus_params
    params.require(:campus).permit(:name, :phone, :custom_domain, :website, :address1, :address2, :city, :state, :zip)
  end
end
