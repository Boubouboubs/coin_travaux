class CompaniesController < ApplicationController
  def index
    @companies = policy_scope(Company)
    @user_project = Project.find(params[:project_id])
  end

  def show
    @company = Company.find(params[:id])
    authorize @company
  end
end
