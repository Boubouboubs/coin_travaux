class CompaniesController < ApplicationController
  def index
    @companies = policy_scope(Company)
    @projects = @companies.projects
    @user_project = Project.find(params[:id])

  end
end
