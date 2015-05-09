class CompanyController < ApplicationController
  before_action :ensure_employer
  before_action :ensure_employer_profile_complete, except: [:edit_employer_profile, :update_employer_profile]

  before_action :set_company

  def show
    @opportunities = @company.opportunities.includes(:applications).all
  end

  def edit_employer_profile
    # TODO render profile form, update the employer password, delete invite
  end

  def update_employer_profile
    if current_user.update(employer_profile_params)
      invite = Invite.find_by(email: current_user.email)
      invite.destroy if invite
      redirect_to user_home_url(current_user), success: "You profile has been saved."
    else
      render :edit_employer_profile
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html{ redirect_to company_url(@company.slug) }
      else
        format.html {render action: 'edit'}
      end
    end
  end

  private

  def ensure_employer_profile_complete
    redirect_to(edit_employer_profile_url, notice: 'Welcome! Please set your password.') unless current_user.valid?
  end

  def set_company
    @company = Company.find_by!(slug: params[:companyslug])
    return if current_user.admin_or_staff?
    redirect_to(company_url(current_user.company.slug)) unless current_user.company.id == @company.id
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:name, :description, :website, :address1, :address2, :city, :state, :zip, :phone)
  end

  def employer_profile_params
    params.require(:employer).permit(:email, :password, :password_confirmation, :first_name, :last_name, :avatar, :city, :state)
  end
end
