class ProjectChangesController < ApplicationController
  before_action :auth_required

  before_action :set_project, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_project_change, only: [:show, :edit, :update, :destroy]

  def new
    @project_change = ProjectChange.new
  end

  def create
    respond_to do |format|
      params[:change].each do |i|
        change = Change.find(i)
        project_change = @project.project_changes.new
        project_change.change_id = i
        
        @activity_log = @project.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se agrego al proyecto el cambio: #{change.identificator}"
        @activity_log.save
        project_change.save
      end
      format.html { redirect_to project_project_changes_path(@project), notice: 'Cambios agregados al proyecto.' }
    end
  end

  def destroy
    @project_change.destroy
    respond_to do |format|
      format.html { redirect_to project_project_changes_path(@project), notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end
    def set_project_change
      @project_change = ProjectChange.find(params[:id])
    end
end
