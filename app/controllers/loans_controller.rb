class LoansController < ApplicationController

  before_action :set_loan, only: [:show, :edit, :update, :destroy]


  def index
  	@loanables = Item.where(is_loanable: Item::LOANABLE)
                     .where("id NOT IN (SELECT item_id FROM loans WHERE status = 1)")
                     .order(:name)
  	@loaned = Loan.joins(:item).where(status: Loan::LOANED).order('items.name')
  end

  def create
    @loan = Loan.new(loan_params)
    @loan.loaned_by = current_user.id
    @loan.status = Loan::LOANED
    respond_to do |format|
      if @loan.save
        @activity_log = @loan.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se prestó #{@loan.item.item_type.name}: #{@loan.item.name} [#{@loan.item.identificator}]"
        @activity_log.save
        format.html { redirect_to action: :index, notice: 'Prestamo creado.' }
        format.json { render :index, status: :created, location: @loan }
      else
        format.html { redirect_to action: :index}
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  def return
    respond_to do |format|
      @loan = Loan.find(params[:loan_id])
      @loan.return_notes = params[:return_notes]
      @loan.status = Loan::RETURNED
      @loan.received_by = current_user.id
      @loan.received_date = Time.now 
      
      if @loan.save

        @activity_log = @loan.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se regresó #{@loan.item.item_type.name}: #{@loan.item.name} [#{@loan.item.identificator}]"
        @activity_log.save

        format.html { redirect_to action: :index, notice: 'Prestamo creado.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { redirect_to action: :index}
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_loan
      @loan = Loan.find(params[:id])
    end

    def loan_params
      params.require(:loan).permit(:person_id, :item_id, :notes, :return_date, :return_notes)
    end
end
