class ItemTypesController < ApplicationController

  before_action :set_item_type, only: [:show, :edit, :update, :destroy, :ui]

  def ui
  	@ids = []
    @ids << @item_type.id
  	get_parent_id(@item_type.item_type_id)
  	@item_types = ItemType.find(@ids.reverse)
    render :layout => false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_type
      @item_type = ItemType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_type_params
      params.require(:item).permit(:name, :field_type, :values, :default, :position)
    end

    def get_parent_id(id)
      if id
        @ids << id
        i = ItemType.find(id)
        get_parent_id(i.item_type_id)
      end
    end
end
