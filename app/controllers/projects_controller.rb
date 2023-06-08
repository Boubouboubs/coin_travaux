class ProjectsController < ApplicationController

  def new
    @project = Project.new
    authorize @project
  end

  def show
    @project = Project.find(params[:id])
    @chosen_company = @project.companies.order(:created_at).first
    authorize @project
  end

end
