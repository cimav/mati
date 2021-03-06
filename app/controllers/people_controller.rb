class PeopleController < ApplicationController

  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
  	@people = Person.all.order(:first_name, :last_name, :last_name2)

    if params[:l] && params[:l] != ''
      @people = @people.where("first_name LIKE :l", l: "#{params[:l]}%")
    else
      @people = @people.where("first_name LIKE 'A%'")
      params[:l] = 'A'
    end

    if params[:b] != 'b'
      @people = @people.where(status: Person::STATUS_ACTIVE)
    end

  end

  def live_search
    @people = Person.order(:first_name, :last_name, :last_name2)
    if !params[:person_q].blank?
      @people = @people.where("(first_name LIKE :q OR last_name LIKE :q OR last_name2 LIKE :q)", {:q => "%#{params[:person_q]}%"})
    end
    if !params[:person_t].blank?
      @people = @people.where(person_type: params[:person_t])
    end
    if params[:b] != 'b'
      @people = @people.where(status: Person::STATUS_ACTIVE)
    end

    render :layout => false
  end



  def new
  	@person = Person.new
  end

  def create
    @person = Person.new(person_params)
    respond_to do |format|
      if @person.save
        # @activity_log = @item.activity_logs.new
        # @activity_log.agent_id = current_user.id
        # @activity_log.message = "El elemento #{@item.name} fue creado."
        # @activity_log.save
        format.html { redirect_to @person, notice: 'Persona creada.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      @person.assign_attributes(person_params)
      changes = @person.changes
      
      if @person.save

        # @activity_log = @item.activity_logs.new
        # @activity_log.agent_id = current_user.id
        # @activity_log.changed_values = changes.to_json
        # @activity_log.message = "El elemento #{@item.name} fue actualizado."
        # @activity_log.save

        # TODO: Borrar campos huerfanos.
        format.html { redirect_to @person, notice: "Persona actualizada correctamente." }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def items
    @person = Person.find(params[:person_id])
  end



  private
    def set_person
      @person = Person.find(params[:id])
    end

    def person_params
      params.require(:person).permit(:first_name, :last_name, :last_name2, :title, :phone, :location_id, :department_id, :people_id, :identificator, :person_type, :email, :person_id)
    end
end
