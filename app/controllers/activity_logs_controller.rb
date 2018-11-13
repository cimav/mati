class ActivityLogsController < ApplicationController

  before_action :set_element, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_activity_log, only: [:show, :edit, :update, :destroy]

  def index
  	@activity_log = @element.activity_logs.new
  	@activity_logs = @element.activity_logs.order('created_at DESC')
  end

  def create
    @activity_log = @element.activity_logs.new(activity_log_params)	
    @activity_log.agent_id = 1
    puts @activity_log.message
    respond_to do |format|
      if @activity_log.save
        format.html { redirect_to item_activity_logs_url(@element), notice: 'Mensaje creado.' }
        format.json { render :show, status: :created, location: @element }
      else
        format.html { redirect_to @element, notice: 'No se pudo guardar mensaje.' }
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
      @element = Item.find(params[:item_id])
    end
    def set_activity_log
      @activity_log = ActivityLog.find(params[:id])
    end
end
