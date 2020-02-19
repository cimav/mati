class AttachmentsController < ApplicationController
  before_action :set_element, only: [:index, :destroy, :create]
  before_action :set_attachment, only: [:destroy]

  def index
  	@attachment = Attachment.new
  	@attachments = @element.attachments.order('file DESC')
  end

  def new
    @attachment = Attachment.new
  end

  def create
    no_error = true
    params[:file].each do |f| 
      @attachment = @element.attachments.new	
      @attachment.agent_id = current_user.id
      @attachment.file = f
      
      if @attachment.save
      	@activity_log = @element.activity_logs.new
        @activity_log.agent_id = current_user.id
        the_file = File.basename(@attachment.file.path)
        @activity_log.message = "El archivo #{the_file} fue subido."
        @activity_log.save
      else 
      	no_error = false
      end
    end
    
    respond_to do |format|
      if no_error
        format.html { redirect_to @element_url, notice: 'Archivo subido correctamente.' }
        format.json { render :show, status: :created, location: @attachment }
      else
        format.html { render :new }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    # url = url_for(action: 'folder_files', controller: 'projects', :project_folder_id => folder_id, id: project_id)

    @attachment.destroy
    respond_to do |format|
      format.html { redirect_to url, notice: 'Archivo eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    def set_element
      uri = URI(request.referrer).path.split('/')
      @referer = ''
      
      if uri[1] == 'contracts'
        @element = Contract.find(params[:contract_id])
        @referer = 'contracts'
        @element_url = contract_attachments_url(@element)
      end

      if uri[1] == 'people'
        @element = Person.find(params[:person_id])
        @referer = 'people'
        @element_url = person_attachments_url(@element)
      end

      if uri[1] == 'tickets'
        @element = Ticket.find(params[:ticket_id])
        @referer = 'tickets'
        @element_url = ticket_attachments_url(@element)
      end

      if uri[1] == 'problems'
        @element = Problem.find(params[:problem_id])
        @referer = 'problems'
        @element_url = problem_attachments_url(@element)
      end

      if uri[1] == 'projects'
        @element = Project.find(params[:project_id])
        @referer = 'projects'
        @element_url = project_attachments_url(@element)
      end

      if uri[1] == 'changes'
        @element = Change.find(params[:change_id])
        @referer = 'changes'
        @element_url = change_attachments_url(@element)
      end

      if uri[2] == 'items'
        @element = Item.find(params[:item_id])
        @referer = 'items'
        @element_url = item_attachments_url(@element)
      end
    end

end
