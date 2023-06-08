class CompaniesController < ApplicationController
  def index
    @companies = policy_scope(Company)
    if params.dig(:filters, :star_rating).present?
      @companies = @companies.select { |c| c.average_rating.round == params[:filters][:star_rating].to_i }
    end
    unless params.dig(:filters, :photo).in? [nil, '']
      if params.dig(:filters, :photo) == "true"
        @companies = @companies.select { |c| c.project_photo.present? }
      end
      if params.dig(:filters, :photo) == "false"
        @companies = @companies.reject { |c| c.project_photo.present? }
      end
    end
    @user_project = Project.find(params[:project_id])



  end

  def show
    @company = Company.find(params[:id])
    authorize @company
  end
end
