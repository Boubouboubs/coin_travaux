class Company < ApplicationRecord
  has_many :project_companies
  has_many :projects, through: :project_companies
  has_many :reviews, through: :project_companies
  has_many :users
end
