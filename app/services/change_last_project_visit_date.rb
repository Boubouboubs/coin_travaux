class ChangeLastProjectVisitDate
  def initialize(project: nil)
    @project = project || Project.order(created_at: :asc).last
  end
  def call
    @project.update(
      visit_date: Time.now - 5.days
    )
  end
end

# ChangeLastProjectVisitDate.new.call
