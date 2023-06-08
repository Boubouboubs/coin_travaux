class ReviewsController < ApplicationController
  def index
    @reviews = policy_scope(Review)
  end
end
