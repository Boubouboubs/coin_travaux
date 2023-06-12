class Project < ApplicationRecord
  PROPERTY_TYPE = ["Appartement neuf", "Appartement ancien", "Maison ancienne", "Maison neuve"]
  RENOVATION_TYPE = ["Rénovation de tout l'appartement", "Rénovation de quelques pièces", "Rénovation d'une pièce", "Extension", "Réaménagement de l’espace"]
  belongs_to :user
  has_many :project_companies
  has_many :companies, through: :project_companies
  has_many :quotes, through: :project_companies

  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :renovation_type, presence: true
  validates :property_type, presence: true
  validates :surface, presence: true, numericality: { greater_than: 0 }
  validates :visit_date, presence: true
  validates :address, presence: true

  def city
    address.split(',').last.strip.capitalize
  end

  def project_with_photo
    if project.photos.empty?
      return nil
    else
      return project.photos.first
    end
  end
end
