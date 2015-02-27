class Admin::UsersController < Admin::ApplicationController
  before_action :set_school
  before_action :set_user

  # GET /users
  # GET /users.json
  def index
    @users = User.where(school: @school)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.school = @school

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_school_users_url(@school), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_school_users_url(@school), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_school_users_url(@school), notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

  def set_school
    return if current_user.type == 'Admin'
    @school = School.find(params[:school_id])
    redirect_to_role(current_user) unless current_user.school == @school
  end

  def set_user
    return if params[:id].nil?
    @user = User.find(params[:id])
    return if current_user.role == 'admin'
    redirect_to admin_school_path(current_user.school) unless @user.school == @school
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    user_type = params[:type] ? params[:type].downcase : :user
    params.require(user_type).permit(:email, :first_name, :last_name, :bio, :address1, :address2, :password, :password_confirmation, :type)
  end
end
