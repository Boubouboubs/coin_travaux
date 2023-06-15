class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def new?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def current_project?
    true
  end
end
