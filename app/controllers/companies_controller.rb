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
      if params.dig(:filters, :existence_years) == "10"
        @companies = @companies.select { |c| (Time.now.to_date - c.creation_date).ceil / 365 < 10 }
      elsif params.dig(:filters, :existence_years) == "29"
        @companies = @companies.select { |c| (Time.now.to_date - c.creation_date).ceil / 365 <= 29 && (Time.now.to_date - c.creation_date).ceil / 365 >= 10 }
      elsif params.dig(:filters, :existence_years) == "30"
        @companies = @companies.select { |c| (Time.now.to_date - c.creation_date).ceil / 365 > 30 }
      end
    end

    if params.dig(:filters, :sorting).present?
      if params.dig(:filters, :sorting) == "Note décroissante"
        @companies = @companies.sort_by { |c| -c.average_rating }
      elsif params.dig(:filters, :sorting) == "Nombre d'avis décroissant"
        @companies = @companies.sort_by { |c| -c.reviews.size }
      elsif params.dig(:filters, :sorting) == "Le + ancien"
        @companies = @companies.sort_by { |c| c.creation_date }
      end
    end

    unless params.dig(:filters, :photo).in? [nil, '']
      if params.dig(:filters, :photo) == "1"
        @companies = @companies.select { |c| c.projects_photos.present? }
      end
      if params.dig(:filters, :photo) == "0"
        @companies = @companies.reject { |c| c.projects_photos.present? }
      end
    end
  end

  def show
    @company = Company.find(params[:id])
    authorize @company
    @project = Project.find(params[:project_id])
  end
end
