class ChangeItemsController < ApplicationController
  before_action :auth_required

  before_action :set_change, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_change_item, only: [:show, :edit, :update, :destroy]

  def new
    @change_item = ChangeItem.new
  end

  def create
    respond_to do |format|
      params[:item].each do |i|
        item = Item.find(i)
        change_item = @change.change_items.new
        change_item.item_id = i
        
        @activity_log = @change.activity_logs.new
        @activity_log.agent_id = current_user.id
        @activity_log.message = "Se agrego al cambio: #{item.name}"
        @activity_log.save
        change_item.save
      end
      format.html { redirect_to change_change_items_path(@change), notice: 'Elementos agregados al contrato.' }
    end
  end

  def destroy
    @change_item.destroy
    respond_to do |format|
      format.html { redirect_to change_change_items_path(@change), notice: 'Elemento eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    def set_change
      @change = Change.find(params[:change_id])
    end
    def set_change_item
      @change_item = ChangeItem.find(params[:id])
    end
end
