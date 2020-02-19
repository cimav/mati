class ProjectProblemsController < ApplicationController
  before_action :auth_required

  before_action :set_project, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_project_problem, only: [:show, :edit, :update, :destroy]

  def new
    @project_problem = ProjectProblem.new
  end

  def create
    respond_to do |format|
      params[:problem].each do |i|
        problem = Problem.find(i)
        project_problem = @project.project_problems.new
        project_problem.problem_id = i
        
        @activity_log = @project.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se agrego al proyecto el problema: #{problem.identificator}"
        @activity_log.save
        project_problem.save
      end
      format.html { redirect_to project_project_problems_path(@project), notice: 'problemas agregados al proyecto.' }
    end
  end

  def destroy
    @project_problem.destroy
    respond_to do |format|
      format.html { redirect_to project_project_problems_path(@project), notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end
    def set_project_problem
      @project_problem = ProjectProblem.find(params[:id])
    end
end
