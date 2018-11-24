class ContractItemsController < ApplicationController
  before_action :auth_required

  before_action :set_contract, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_contract_item, only: [:show, :edit, :update, :destroy]

  def new
    @contract_item = ContractItem.new
  end

  def create
    respond_to do |format|
      params[:item].each do |i|
        item = Item.find(i)
        contract_item = @contract.contract_items.new
        contract_item.item_id = i
        
        @activity_log = @contract.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se agrego al contracto: #{item.name}"
        @activity_log.save
        contract_item.save
      end
      format.html { redirect_to contract_contract_items_path(@contract), notice: 'Elementos agregados al contrato.' }
    end
  end

  def destroy
    @contract_item.destroy
    respond_to do |format|
      format.html { redirect_to contract_contract_items_path(@contract), notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_contract
      @contract = Contract.find(params[:contract_id])
    end
    def set_contract_item
      @contract_item = ContractItem.find(params[:id])
    end

end
