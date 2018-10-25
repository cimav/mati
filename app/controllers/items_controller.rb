class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    puts params
    respond_to do |format|
      if @item.save
        params.each do |k,v|
          if k.start_with?('extra-')
            extra_id = k.sub('extra-', '')
            data = ItemDatum.new
            data.item_id = @item.id
            data.item_field_id = extra_id
            data.value = v
            data.save
          end
        end
        format.html { redirect_to items_path, notice: 'Elemento creado.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to items_path, notice: 'Elemento actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_path, notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :item_type_id, :identificator, :impact, :location_id, :department_id, :used_by, :managed_by, :assigned_on)
    end
end
