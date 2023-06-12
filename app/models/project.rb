class Project < ApplicationRecord
  PROPERTY_TYPE = ["Appartement neuf", "Appartement ancien", "Maison ancienne", "Maison neuve"]
  RENOVATION_TYPE = ["Rénovation de tout l'appartement", "Rénovation d'une pièce", "Extension", "Rénovation de quelques pièces", "Réaménagement de l’espace"]
  belongs_to :user
  has_many :project_companies
  has_many :companies, through: :project_companies
  has_many :quotes, through: :project_companies

  has_many_attached :photos

  before_create :set_jwt_token

  def set_jwt_token
    twilio_service = TwilioService.new(self)
    self.jwt_token = twilio_service.generate_token
  end

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
