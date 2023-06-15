class AddVisitCompletedToProjects < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :visit_completed, :boolean, default: false
  end
end
