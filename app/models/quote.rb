class Quote < ApplicationRecord
  belongs_to :project_company
  belongs_to :project, through: :project_company
end
