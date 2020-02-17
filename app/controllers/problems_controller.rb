class ProblemsController < ApplicationController
  before_action :auth_required
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  def index
    @problems = Problem.where(status: [Problem::STATUS_OPEN, Problem::STATUS_PENDING]).order('created_at DESC')
  end

  def all
    @problems = Problem.order('created_at DESC')
  end

  def show
  end

  def new
    @problem = Problem.new
  end

  def edit
  end

  def create
    @problem = Problem.new(problem_params)
    @problem.person_id = current_user.person.id
    respond_to do |format|
      if @problem.save
        @activity_log = @problem.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "El problema #{@problem.identificator} fue creado."
        @activity_log.save
        format.html { redirect_to @problem, notice: 'Elemento creado.' }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html { render :new }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      from = Person.find(current_user.person_id)
      to = Person.find(@problem.person_id)

      if !params[:problem_message].blank?
        msg = @problem.problem_responses.new
        msg.message = params[:problem_message]
        msg.from = from
        msg.to = to
        msg.save     
      end
      @problem.assign_attributes(problem_params)
      changes = @problem.changes
      
      
      if @problem.save
        @activity_log = @problem.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.changed_values = changes.to_json
        @activity_log.message = "El problem #{@problem.identificator} fue actualizado."
        @activity_log.save

        format.html { redirect_to @problem, notice: "problem actualizado correctamente." }
        format.json { render :show, status: :ok, location: @problem }
      else
        format.html { render :edit }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @problem.destroy
    respond_to do |format|
      format.html { redirect_to problems_path, notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_problem
      @problem = Problem.find(params[:id])
    end

    def problem_params
      params.require(:problem).permit(:agent_id, :person_id, :description, :cause, :impact, :symptom, :solution, :priority, :status)
    end
end
