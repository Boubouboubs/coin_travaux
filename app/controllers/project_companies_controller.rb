class ProjectCompaniesController < ApplicationController
  def new
    @project_company = Project.new
    authorize @project
  end

  def create
    @project_company = ProjectCompany.new(project_company_params)
    @company = Company.find(params[:project_company][:company_id])
    @project = Project.find(params[:project_id])
    @project_company.project = @project
    @project_company.company = @company
    authorize @project_company
    if @project_company.save
      redirect_to project_path(@project)
    else
      render "companies/show", status: :unprocessable_entity
    end
  end

  private

  def project_company_params
    params.require(:project_company).permit(:company_id)
  end
end
