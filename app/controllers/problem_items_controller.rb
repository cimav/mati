class ProblemItemsController < ApplicationController
  before_action :auth_required

  before_action :set_problem, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_problem_item, only: [:show, :edit, :update, :destroy]

  def new
    @problem_item = ProblemItem.new
  end

  def create
    respond_to do |format|
      params[:item].each do |i|
        item = Item.find(i)
        problem_item = @problem.problem_items.new
        problem_item.item_id = i
        
        @activity_log = @problem.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se agrego al problemo: #{item.name}"
        @activity_log.save
        problem_item.save
      end
      format.html { redirect_to problem_problem_items_path(@problem), notice: 'Elementos agregados al contrato.' }
    end
  end

  def destroy
    @problem_item.destroy
    respond_to do |format|
      format.html { redirect_to problem_problem_items_path(@problem), notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_problem
      @problem = Problem.find(params[:problem_id])
    end
    def set_problem_item
      @problem_item = ProblemItem.find(params[:id])
    end
end
