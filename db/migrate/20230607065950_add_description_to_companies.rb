class AddDescriptionToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :description, :text
  end
end
