class LoansController < ApplicationController

  before_action :set_loan, only: [:show, :edit, :update, :destroy]


  def index
  	@loanables = Item.where('is_loanable = 1').order(:name)
  	@loaned = Loan.joins(:item).where(:status => Loan::LOANED).order('items.name')
  end

  def create
    @loan = loan.new(loan_params)
    respond_to do |format|
      if @loan.save
        @activity_log = @loan.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "El contrato #{@loan.name} fue creado."
        @activity_log.save
        format.html { redirect_to @loan, notice: 'Contrato creado.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @loan.assign_attributes(loan_params)
      changes = @loan.changes
      
      if @loan.save

        @activity_log = @loan.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.changed_values = changes.to_json
        @activity_log.message = "El contrato #{@loan.name} fue actualizado."
        @activity_log.save

        format.html { redirect_to @loan, notice: "Contrato actualizado correctamente." }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_loan
      @loan = loan.find(params[:id])
    end

    def loan_params
      params.require(:loan).permit(:name, :number, :loan_type, :description, :start_date, :end_date, :notify_days, :notify_to, :cost, :status)
    end
end
