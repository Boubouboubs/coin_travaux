class ProjectsController < ApplicationController

  def new
    @project = Project.new
    authorize @project
  end
end
