class ProjectItemsController < ApplicationController
  before_action :auth_required

  before_action :set_project, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_project_item, only: [:show, :edit, :update, :destroy]

  def new
    @project_item = ProjectItem.new
  end

  def create
    respond_to do |format|
      params[:item].each do |i|
        item = Item.find(i)
        project_item = @project.project_items.new
        project_item.item_id = i
        
        @activity_log = @project.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se agrego al proyecto: #{item.name}"
        @activity_log.save
        project_item.save
      end
      format.html { redirect_to project_project_items_path(@project), notice: 'Elementos agregados al proyecto.' }
    end
  end

  def destroy
    @project_item.destroy
    respond_to do |format|
      format.html { redirect_to project_project_items_path(@project), notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end
    def set_project_item
      @project_item = ProjectItem.find(params[:id])
    end
end
