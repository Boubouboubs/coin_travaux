class ReviewsController < ApplicationController
  def index
    @reviews = policy_scope(Review)
    @user_project = Project.find(params[:project_id])
  end
end
