class PeopleController < ApplicationController

  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
  	@people = Person.all
  end

  private
    def set_person
      @person = Person.find(params[:id])
    end
end
