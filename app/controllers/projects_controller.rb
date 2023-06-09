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

  def create
    @project = Project.new(project_params)
    authorize @project
    @project.user = current_user
    if @project.save
      redirect_to project_companies_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
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

  def project_params
    params.require(:project).permit(:visit_date, :property_type, :address, :surface)
  end

end
