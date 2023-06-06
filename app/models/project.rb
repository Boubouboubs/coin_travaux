class Project < ApplicationRecord
  belongs_to :user
  has_many :project_companies
  has_many :quotes, through: :project_companies
end
