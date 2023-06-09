class Quote < ApplicationRecord
  belongs_to :project_company
  has_one :project, through: :project_company
  has_one :company, through: :project_company

  has_one_attached :file
end
