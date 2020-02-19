class ChangeTicketsController < ApplicationController
  before_action :auth_required

  before_action :set_change, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_change_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @change_ticket = ChangeTicket.new
  end

  def create
    respond_to do |format|
      params[:ticket].each do |i|
        ticket = Ticket.find(i)
        change_ticket = @change.change_tickets.new
        change_ticket.ticket_id = i
        
        @activity_log = @change.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se agrego al changea el ticket: #{ticket.identificator}"
        @activity_log.save
        change_ticket.save
      end
      format.html { redirect_to change_change_tickets_path(@change), notice: 'Tickets agregados al changea.' }
    end
  end

  def destroy
    @change_ticket.destroy
    respond_to do |format|
      format.html { redirect_to change_change_tickets_path(@change), notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_change
      @change = Change.find(params[:change_id])
    end
    def set_change_ticket
      @change_ticket = ChangeTicket.find(params[:id])
    end
end
