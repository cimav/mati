class ProblemTicketsController < ApplicationController
  before_action :auth_required

  before_action :set_problem, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_problem_ticket, only: [:show, :edit, :update, :destroy]

  def new
    @problem_ticket = ProblemTicket.new
  end

  def create
    respond_to do |format|
      params[:ticket].each do |i|
        ticket = Ticket.find(i)
        problem_ticket = @problem.problem_tickets.new
        problem_ticket.ticket_id = i
        
        @activity_log = @problem.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se agrego al problema el ticket: #{ticket.identificator}"
        @activity_log.save
        problem_ticket.save
      end
      format.html { redirect_to problem_problem_tickets_path(@problem), notice: 'Tickets agregados al problema.' }
    end
  end

  def destroy
    @problem_ticket.destroy
    respond_to do |format|
      format.html { redirect_to problem_problem_tickets_path(@problem), notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_problem
      @problem = Problem.find(params[:problem_id])
    end
    def set_problem_ticket
      @problem_ticket = ProblemTicket.find(params[:id])
    end
end
