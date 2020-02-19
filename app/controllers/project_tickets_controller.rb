class ProjectTicketsController < ApplicationController
  before_action :auth_required

  before_action :set_project, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_project_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @project_ticket = ProjectTicket.new
  end

  def create
    respond_to do |format|
      params[:ticket].each do |i|
        ticket = Ticket.find(i)
        project_ticket = @project.project_tickets.new
        project_ticket.ticket_id = i
        
        @activity_log = @project.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se agrego al projecta el ticket: #{ticket.identificator}"
        @activity_log.save
        project_ticket.save
      end
      format.html { redirect_to project_project_tickets_path(@project), notice: 'Tickets agregados al proyecto.' }
    end
  end

  def destroy
    @project_ticket.destroy
    respond_to do |format|
      format.html { redirect_to project_project_tickets_path(@project), notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:project_id])
    end
    def set_project_ticket
      @project_ticket = ProjectTicket.find(params[:id])
    end
end
