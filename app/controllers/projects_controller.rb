class ProjectsController < ApplicationController

  def index
    @projects = policy_scope(Project).where(user_id: current_user.id)
  end

  def new
    @project = Project.new
    authorize @project
  end

  def show
    @project = Project.find(params[:id])
    @user = @project.companies.first.users.first unless @project.companies.empty?
    setup_video_call_token if @user

    # @projects = policy_scope(Project).where(user_id: current_user.id)
    @markers = [{
      lat: @project.latitude,
      lng: @project.longitude,
      marker_html: render_to_string(partial: "marker")
    }]

    @chosen_company = @project.companies.order(:created_at).first
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

  def current_project
    @project = current_user.projects.last
    authorize @project
    redirect_to project_path(@project)
  end

  private

  def setup_video_call_token
    # No chatting with yourself
    # return if @user == current_user

    twilio = TwilioService.new
    twilio.generate_token(@project, current_user)
    @twilio_jwt = twilio.jwt
    @room_id = twilio.room_id
  end

  def project_params
    params.require(:project).permit(:visit_date, :property_type, :address, :surface, :renovation_type)
  end

end
