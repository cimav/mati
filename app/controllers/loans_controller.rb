class LoansController < ApplicationController

  before_action :set_loan, only: [:show, :edit, :update, :destroy]


  def index
  	@loanables = Item.where('is_loanable = 1').order(:name)
  	@loaned = Loan.joins(:item).where(:status => Loan::LOANED).order('items.name')
  end

  def create
    @loan = Loan.new(loan_params)
    respond_to do |format|
      if @loan.save
        @activity_log = @loan.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "El prestamo #{@loan.name} fue creado."
        @activity_log.save
        format.html { redirect_to @loan, notice: 'Prestamo creado.' }
        format.json { render :index, status: :created, location: @loan }
      else
        format.html { render :index }
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
        @activity_log.message = "El prestamo #{@loan.name} fue actualizado."
        @activity_log.save

        format.html { redirect_to @loan, notice: "Prestamo actualizado correctamente." }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_loan
      @loan = Loan.find(params[:id])
    end

    def loan_params
      params.require(:loan).permit(:people_id, :item_id, :notes, :end_date)
    end
end
