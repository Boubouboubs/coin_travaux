class ChangeVisitDateToProjects < ActiveRecord::Migration[7.0]
  def change
    change_column :projects, :visit_date, :datetime
  end
end
