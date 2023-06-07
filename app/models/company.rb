class Company < ApplicationRecord
  has_many :project_companies, dependent: :destroy
  has_many :projects, through: :project_companies
  has_many :reviews, through: :project_companies
  has_many :users, dependent: :destroy

  has_one_attached :logos
end
