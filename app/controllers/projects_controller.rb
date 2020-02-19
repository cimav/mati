class ProjectsController < ApplicationController
   before_action :auth_required
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.where(status: [Project::STATUS_OPEN, Project::STATUS_PENDING]).order('created_at DESC')
  end

  def all
    @projects = Project.order('created_at DESC')
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.person_id = current_user.person.id
    respond_to do |format|
      if @project.save
        @activity_log = @project.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "El proyecto #{@project.identificator} fue creado."
        @activity_log.save
        format.html { redirect_to @project, notice: 'Elemento creado.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      
      @project.assign_attributes(project_params)
      projects = @project.changes
      
      
      if @project.save
        @activity_log = @project.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.changed_values = projects.to_json
        @activity_log.message = "El proyecto #{@project.identificator} fue actualizado."
        @activity_log.save

        format.html { redirect_to @project, notice: "Cambio actualizado correctamente." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:agent_id, :person_id, :description, :start_date_planned, :end_date_planned, :start_date_real, :end_date_real, :priority, :status)
    end
end
