class CompaniesController < ApplicationController
  def index
    @companies = policy_scope(Company)
    @projects = @companies
    @user_project = current_user.projects
  end

  def show
    @companies = company.find(params[:id])
  end
end
