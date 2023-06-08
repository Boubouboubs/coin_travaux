class Project < ApplicationRecord
  RENOVATION_TYPE = ["Rénovation de tout l'appartement", "Rénovation d'une pièce", "Extension", "Rénovation de quelques pièces", "Réaménagement de l’espace"]
  belongs_to :user
  has_many :project_companies
  has_many :companies, through: :project_companies
  has_many :quotes, through: :project_companies

  has_many_attached :photos
end
