class Company < ApplicationRecord
  has_many :project_companies, dependent: :destroy
  has_many :projects, through: :project_companies
  has_many :reviews, through: :project_companies
  has_many :users, dependent: :destroy

  has_one_attached :logo

  def project_photo
    return nil unless projects.present?

    project_with_photos = projects.find { |project| !project.photos.empty? }
    return nil unless project_with_photos

    project_with_photos.photos
  end

  def average_rating
    reviews.average(:rating)
  end
end
