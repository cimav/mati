class ItemRelationshipsController < ApplicationController
  before_action :set_item, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_item_relationship, only: [:show, :edit, :update, :destroy]

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:item_id])
    end
    def set_item_relationship
      @item = Item.find(params[:item_id])
    end
end
