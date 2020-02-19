class ChangeProblemsController < ApplicationController
  before_action :auth_required

  before_action :set_change, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_change_problem, only: [:show, :edit, :update, :destroy]

  def new
    @change_problem = ChangeProblem.new
  end

  def create
    respond_to do |format|
      params[:problem].each do |i|
        problem = Problem.find(i)
        change_problem = @change.change_problems.new
        change_problem.problem_id = i
        
        @activity_log = @change.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se agrego al cambio el problema: #{problem.identificator}"
        @activity_log.save
        change_problem.save
      end
      format.html { redirect_to change_change_problems_path(@change), notice: 'problemas agregados al changea.' }
    end
  end

  def destroy
    @change_problem.destroy
    respond_to do |format|
      format.html { redirect_to change_change_problems_path(@change), notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_change
      @change = Change.find(params[:change_id])
    end
    def set_change_problem
      @change_problem = ChangeProblem.find(params[:id])
    end
end
