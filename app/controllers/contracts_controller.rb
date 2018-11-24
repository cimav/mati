class ContractsController < ApplicationController

  before_action :set_contract, only: [:show, :edit, :update, :destroy]

  def index
  	@contracts = Contract.all
  end

  def new
  	@contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    respond_to do |format|
      if @contract.save
        @activity_log = @contract.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "El contrato #{@contract.name} fue creado."
        @activity_log.save
        format.html { redirect_to @contract, notice: 'Contrato creado.' }
        format.json { render :show, status: :created, location: @contract }
      else
        format.html { render :new }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @contract.assign_attributes(contract_params)
      changes = @contract.changes
      
      if @contract.save

        @activity_log = @contract.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.changed_values = changes.to_json
        @activity_log.message = "El contrato #{@contract.name} fue actualizado."
        @activity_log.save

        format.html { redirect_to @contract, notice: "Contrato actualizado correctamente." }
        format.json { render :show, status: :ok, location: @contract }
      else
        format.html { render :edit }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_contract
      @contract = Contract.find(params[:id])
    end

    def contract_params
      params.require(:contract).permit(:name, :number, :contract_type, :description, :start_date, :end_date, :notify_days, :notify_to, :cost, :status)
    end
end

