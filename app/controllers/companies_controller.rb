class CompaniesController < ApplicationController
  def index
    @companies = policy_scope(Company)
    @project_id = params[:project_id].to_i
    if params.dig(:filters, :star_rating).present?
      @companies = @companies.select { |c| c.average_rating.round == params[:filters][:star_rating].to_i }
    end

    if params.dig(:filters, :review_number).present?
      @companies = @companies.select { |c| c.reviews.size >= params[:filters][:review_number].to_i }
    end

    if params.dig(:filters, :existence_years).present?
      if params.dig(:filters, :existence_years) == "2"
        @companies = @companies.select { |c| (Time.now.to_date - c.creation_date).ceil / 365 >= params[:filters][:creation_date].to_i }
      end
    end

    unless params.dig(:filters, :photo).in? [nil, '']
      if params.dig(:filters, :photo) == "1"
        @companies = @companies.select { |c| c.project_photo.present? }
      end
      if params.dig(:filters, :photo) == "0"
        @companies = @companies.reject { |c| c.project_photo.present? }
      end
    end
  end

  def show
    @company = Company.find(params[:id])
    authorize @company
    @project = Project.find(params[:project_id])
  end
end
