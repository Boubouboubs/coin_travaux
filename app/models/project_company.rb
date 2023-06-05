class ProjectCompany < ApplicationRecord
  belongs_to :project
  belongs_to :company
  has_many :reviews
  has_many :quotes
end
