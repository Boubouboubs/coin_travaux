class ProjectCompany < ApplicationRecord
  belongs_to :project
  belongs_to :company
  has_many :reviews, dependent: :destroy
  has_one :quote, dependent: :destroy
end
