class ProjectsController < ApplicationController

  def new
    @project = Project.new
    authorize @project
  end

  def show
    @project = Project.find(params[:id])
    @user = @project.companies.first.users.first
    setup_video_call_token

    @chosen_company = @project.companies.order(:created_at).first
    # @second_company = @project.companies.order(:created_at).second
    # @third_company = @project.companies.order(:created_at).third
    authorize @project
  end

  private

  def setup_video_call_token
    # No chatting with yourself
    return if @user == current_user

    twilio = TwilioService.new
    twilio.generate_token(current_user, @user)
    @twilio_jwt = twilio.jwt
    @room_id = twilio.room_id
  end

end
