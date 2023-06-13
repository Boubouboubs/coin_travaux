class Company < ApplicationRecord
  has_many :project_companies, dependent: :destroy
  has_many :projects, through: :project_companies
  has_many :reviews, through: :project_companies
  has_many :users, dependent: :destroy

  has_one_attached :logo

  def projects_photos
    return nil unless projects.present?

    projects_with_photos = projects.select { |project| !project.photos.empty? }
    return nil unless projects_with_photos

    projects_with_photos.flat_map(&:photos)
  end

  def average_rating
    reviews.average(:rating)
  end
end
