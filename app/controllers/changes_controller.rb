class ChangesController < ApplicationController
  before_action :auth_required
  before_action :set_change, only: [:show, :edit, :update, :destroy]

  def index
    @changes = Change.where(status: [Change::STATUS_OPEN, Change::STATUS_PENDING]).order('created_at DESC')
  end

  def all
    @changes = Change.order('created_at DESC')
  end

  def show
  end

  def new
    @change = Change.new
  end

  def edit
  end

  def create
    @change = Change.new(change_params)
    @change.person_id = current_user.person.id
    respond_to do |format|
      if @change.save
        @activity_log = @change.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "El cambio #{@change.identificator} fue creado."
        @activity_log.save
        format.html { redirect_to @change, notice: 'Elemento creado.' }
        format.json { render :show, status: :created, location: @change }
      else
        format.html { render :new }
        format.json { render json: @change.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      from = Person.find(current_user.person_id)
      to = Person.find(@change.person_id)

      if !params[:change_message].blank?
        msg = @change.change_responses.new
        msg.message = params[:change_message]
        msg.from = from
        msg.to = to
        msg.save     
      end
      @change.assign_attributes(change_params)
      changes = @change.changes
      
      
      if @change.save
        @activity_log = @change.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.changed_values = changes.to_json
        @activity_log.message = "El cambio #{@change.identificator} fue actualizado."
        @activity_log.save

        format.html { redirect_to @change, notice: "Cambio actualizado correctamente." }
        format.json { render :show, status: :ok, location: @change }
      else
        format.html { render :edit }
        format.json { render json: @change.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @change.destroy
    respond_to do |format|
      format.html { redirect_to changes_path, notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_change
      @change = Change.find(params[:id])
    end

    def change_params
      params.require(:change).permit(:agent_id, :person_id, :description, :reason, :impact, :rollout_plan, :backout_plan, :change_type, :risk_type, :start_date_planned, :end_date_planned, :start_date_real, :end_date_real, :priority, :status)
    end
end
