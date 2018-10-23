class ItemFieldsController < ApplicationController
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_field
      @item = ItemField.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_field_params
      params.require(:item).permit(:name, :field_type, :values, :default, :position)
    end
end
