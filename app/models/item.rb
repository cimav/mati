class Item < ApplicationRecord

  
  belongs_to :item_type
  belongs_to :department
  belongs_to :location
  belongs_to :user, :foreign_key => "used_by", :class_name => "Person"
  belongs_to :agent, :foreign_key => "managed_by", :class_name => "Agent"
  has_many :item_data

  has_many :relationship_children, :foreign_key => "parent_id", :class_name => "ItemRelationship"
  has_many :relationship_parents, :foreign_key => "child_id", :class_name => "ItemRelationship"


  has_many :activity_logs, as: :element
  has_many :attachments, as: :element

  has_many :contract_items
  has_many :ticket_items
  has_many :loans

  LOANABLE = 1

  IMPACT_LOW    = 1
  IMPACT_MEDIUM = 2
  IMPACT_HIGH   = 3

  ITEM_HARDWARE       = 1
  ITEM_SOFTWARE       = 2
  ITEM_COMMUNICATIONS = 3
  ITEM_LOCATION       = 4

  IMPACT = {
    IMPACT_LOW    => 'Bajo',
    IMPACT_MEDIUM => 'Medio',
    IMPACT_HIGH   => 'Alto'
  }


  FIELDS = {
    'name' => 'Nombre',
    'description' => 'Descripción',
    'item_type_id' => 'Tipo',
    'identificator' => 'Identificador',
    'impact' => 'Impacto',
    'location_id' => 'Ubicación',
    'department_id' => 'Departamento',
    'used_by' => 'Usado por',
    'managed_by' => 'Administrado por',
    'assigned_on' => 'Fecha asignación',
    'is_loanable' => 'Disponible para préstamo'
  }

  def field_text(f)
    if FIELDS[f]
      v = FIELDS[f]
    else 
      v = f
    end
    return v 
  end

end
