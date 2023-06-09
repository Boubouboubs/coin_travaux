class ProjectCompaniesController < ApplicationController
  def create
    @project_company = ProjectCompany.new(project_company_params)
    @company = Company.find(params[:id])
    @project = Project.find(param[:project_id])
    @project_company.project_id = @project
    @project_company.company_id = @company
    if @project_company.save
      redirect_to project_path(@project_id)
    else
      render project_companies_path, status: :unprocessable_entity
    end
  end

  private

  def project_company_params
    params.require(:project_company).permit(:reviews, :quotes)
  end
end
