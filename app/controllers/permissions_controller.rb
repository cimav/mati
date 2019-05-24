class PermissionsController < ApplicationController
  before_action :set_person, only: [:index, :destroy, :create]
  before_action :set_permission, only: [:destroy]

  def index
  	@permission = Permission.new
  	@permissions = @person.permissions.order('created_at DESC')
    @list = Item.where(has_access_controls: true).where.not(id: @permissions.map(&:item_id)).order('name')
  end

  def new
    @permission = Permission.new
  end

  def create
    @permission = @person.permissions.new(permissions_params)
    @permission.agent_id = current_user.id
    @permission.status = Permission::ACTIVE


    respond_to do |format|
      if @permission.save
        @activity_log = @person.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "El permiso fue agregado."
        @activity_log.save
        format.html { redirect_to person_permissions_path(@person), notice: 'Permiso agregado.' }
        format.json { render :show, status: :created, location: @permission }
      else
        puts @permission.errors.full_messages
        format.html { redirect_to person_permissions_path(@person) }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @permission.status = Permission::REMOVED
    @permission.removed_date = Date.today
    respond_to do |format|
      if @permission.save
        format.html { redirect_to person_permissions_path(@person), notice: 'Permiso eliminado.' }
        format.json { head :no_content }
      end
    end
  end

  private
    def permissions_params
      params.require(:permission).permit(:item_id, :notes, :removed_date, :removed_notes)
    end
    def set_permission
      @permission = Permission.find(params[:id])
    end

    def set_person
      @person = Person.find(params[:person_id])
    end


end

