# encoding: utf-8
class TicketsController < ApplicationController
  before_action :auth_required
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.where(status: [Ticket::STATUS_OPEN, Ticket::STATUS_PENDING]).order('created_at DESC')
  end

  def all
    @tickets = Ticket.order('created_at DESC')
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)
    respond_to do |format|
      if @ticket.save
        @activity_log = @ticket.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "El ticket #{@ticket.identificator} fue creado."
        @activity_log.save
        format.html { redirect_to @ticket, notice: 'Elemento creado.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if params[:ticket_message] 
        msg = @ticket.ticket_responses.new
        msg.message = params[:ticket_message]
        msg.from = Person.find(current_user.person_id)
        msg.to = Person.find(@ticket.person_id)
        msg.save

        body = render_to_string(template: 'mails/ticket_message', layout: false,  locals: {ticket: @ticket, message: msg})
        current_user.send_mail(msg.to.email, "Actualización ticket #{@ticket.identificator}", body)
        
      end
      @ticket.assign_attributes(ticket_params)
      changes = @ticket.changes
      
      
      if @ticket.save
        @activity_log = @ticket.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.changed_values = changes.to_json
        @activity_log.message = "El ticket #{@ticket.identificator} fue actualizado."
        @activity_log.save

        if @ticket.status == Ticket::STATUS_CLOSED
          TicketMailer.ticket_closed(@ticket).deliver_later
        end

        format.html { redirect_to @ticket, notice: "Ticket actualizado correctamente." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_path, notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:agent_id, :person_id, :description, :service_id, :priority, :status)
    end
end
