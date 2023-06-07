class CompaniesController < ApplicationController
  def index
    @companies = policy_scope(Company)
    @projects = @companies
    @user_project = current_user.projects
  end

  def show
    @company = Company.find(params[:id])
    authorize @company
  end
end
