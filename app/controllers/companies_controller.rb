class CompaniesController < ApplicationController
  def index
    @companies = policy_scope(Company)
    @user_project = Project.find(params[:project_id])
    @company_rating = []
  end
end
