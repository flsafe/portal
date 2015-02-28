class CompanyController < ApplicationController
  before_action :set_company

  def show
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

  def set_company
    @company = Company.find_by!(slug: params[:companyslug])
    return if current_user.admin_or_staff?
    redirect_to(company_url(current_user.company.slug)) unless current_user.company.id == @company.id
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def company_params
    params.require(:company).permit(:name, :description, :website, :address1, :address2, :city, :state, :zip, :phone)
  end
end
