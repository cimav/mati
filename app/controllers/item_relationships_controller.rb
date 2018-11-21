class ItemRelationshipsController < ApplicationController
  before_action :auth_required

  before_action :set_item, only: [:index, :show, :new, :edit, :update, :destroy, :create]
  before_action :set_item_relationship, only: [:show, :edit, :update, :destroy]


  def new
    @item_relationship = ItemRelationship.new
  end

  def create
    respond_to do |format|
      params[:item].each do |i|
        rel_params = params[:relationship].split('-')
        

        if rel_params[0] == 'dir'
          rel = @item.relationship_children.new
          rel.child_id  = i
        else
          rel = @item.relationship_parents.new
          rel.parent_id  = i
        end
        rel.relationship_id = rel_params[1]
        
        if rel_params[0] == 'dir'
          rel_type = rel.relationship.name
        else
          rel_type = rel.relationship.inverse
        end
        
        @activity_log = @item.activity_logs.new
        @activity_log.agent_id = current_user.id
        rel_i = Item.find(i)
        @activity_log.message = "Se agrego la relación: #{rel_type} #{rel_i.name}"
        @activity_log.save
        rel.save
      end
      format.html { redirect_to item_item_relationships_path(@item), notice: 'Relación creada.' }
    end
  end

  def destroy
    @item_relationship.destroy
    respond_to do |format|
      format.html { redirect_to item_item_relationships_path(@item), notice: 'Relacion eliminada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:item_id])
    end
    def set_item_relationship
      @item_relationship = ItemRelationship.find(params[:id])
    end
end
