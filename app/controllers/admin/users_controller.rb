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
      # We let admin and staff create a new record with minimal fields. The associated user
      # will fill out the rest.
      @user.errors.add(:email, 'You must provide an email address.') if user_params[:email].blank?
      @user.errors.add(:email, 'You must provide a unique email address.') if User.find_by(email: user_params[:email])

      @user.errors.add(:password, 'You must provide a password.') if user_params[:password].blank?
      @user.errors.add(:password_confirmation, 'You must provide a password confirmation.') if user_params[:password_confirmation].blank?
      @user.errors.add(:password_confirmation, 'Password confirmation must match password.') if user_params[:password_confirmation] != user_params[:password]
      if @user.errors.empty? && @user.save(validate: false)
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
      @user.attributes = user_params
      if @user.save(validate: false)
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
    @school = School.find(params[:school_id])
    return if current_user.type == 'Admin'
    redirect_home(current_user) unless current_user.school == @school
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
    params.require(user_type).permit(:email, :password, :password_confirmation, :avatar,  :first_name, :last_name, :phone, :bio, :address1, :city, :state, :zip, :type)
  end
end
