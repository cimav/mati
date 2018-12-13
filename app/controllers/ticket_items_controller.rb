class TicketItemsController < ApplicationController
  before_action :auth_required

  before_action :set_ticket, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_ticket_item, only: [:show, :edit, :update, :destroy]

  def new
    @ticket_item = TicketItem.new
  end

  def create
    respond_to do |format|
      params[:item].each do |i|
        item = Item.find(i)
        ticket_item = @ticket.ticket_items.new
        ticket_item.item_id = i
        
        @activity_log = @ticket.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se agrego al ticketo: #{item.name}"
        @activity_log.save
        ticket_item.save
      end
      format.html { redirect_to ticket_ticket_items_path(@ticket), notice: 'Elementos agregados al contrato.' }
    end
  end

  def destroy
    @ticket_item.destroy
    respond_to do |format|
      format.html { redirect_to ticket_ticket_items_path(@ticket), notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end
    def set_ticket_item
      @ticket_item = TicketItem.find(params[:id])
    end
end
