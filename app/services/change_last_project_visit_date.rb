class ChangeLastProjectVisitDate
  def call
    project = Project.order(created_at: :asc).last
    project.update(
      visit_date: Time.now - 5.days
    )
  end
end

# ChangeLastProjectVisitDate.new.call
