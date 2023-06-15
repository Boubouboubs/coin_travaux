class ChangeVisitCompleted
  def initialize(project: nil)
    @project = project || Project.order(created_at: :asc).last
  end
  def call
    @project.update(
      visit_completed: true
    )
  end
end

# ChangeVisitCompleted.new.call

# class ChangeLastProjectVisitDate
#   def initialize(project: nil)
#     @project = project || Project.order(created_at: :asc).last
#   end
#   def call
#     @project.update(
#       visit_date: @project.visit_date + 5.days
#     )
#   end
# end

# ChangeLastProjectVisitDate.new.call
