class ActivityLogsController < ApplicationController

  before_action :set_element, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_activity_log, only: [:show, :edit, :update, :destroy]

  def index
  	@activity_log = @element.activity_logs.new
  	@activity_logs = @element.activity_logs.order('created_at DESC')
  end

  def create
    @activity_log = @element.activity_logs.new(activity_log_params)	
    @activity_log.agent_id = current_user.id

    respond_to do |format|
      if @activity_log.save
        format.html { redirect_to @element_url, notice: 'Mensaje creado.' }
        format.json { render :show, status: :created, location: @element }
      else
        format.html { redirect_to @element_url, notice: 'No se pudo guardar mensaje.' }
        format.json { render json: @activity_log.errors, status: :unprocessable_entity }
      end
    end  
  end

  private
    def activity_log_params
      params.require(:activity_log).permit(:message)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_element
      # Hack para element
      uri = URI(request.referrer).path.split('/')
      @referer = ''
      
      if uri[1] == 'contracts'
        @element = Contract.find(params[:contract_id])
        @referer = 'contracts'
        @element_url = contract_activity_logs_url(@element)
      end

      if uri[1] == 'tickets'
        @element = Ticket.find(params[:ticket_id])
        @referer = 'tickets'
        @element_url = ticket_activity_logs_url(@element)
      end

      if uri[1] == 'problems'
        @element = Problem.find(params[:problem_id])
        @referer = 'problems'
        @element_url = problem_activity_logs_url(@element)
      end

      if uri[1] == 'changes'
        @element = Change.find(params[:change_id])
        @referer = 'changes'
        @element_url = change_activity_logs_url(@element)
      end

      if uri[1] == 'projects'
        @element = Project.find(params[:project_id])
        @referer = 'projects'
        @element_url = project_activity_logs_url(@element)
      end

      if uri[1] == 'people'
        @element = Person.find(params[:person_id])
        @referer = 'people'
        @element_url = person_activity_logs_url(@element)
      end

      if uri[2] == 'items'
        @element = Item.find(params[:item_id])
        @referer = 'items'
        @element_url = item_activity_logs_url(@element)
      end


    end
    def set_activity_log
      @activity_log = ActivityLog.find(params[:id])
    end
end
