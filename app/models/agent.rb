class Agent < ApplicationRecord
  belongs_to :person
  has_many :tickets


  STATUS_ACTIVE = 1
  STATUS_INACTIVE = 2

  AGENT = 1
  ADMIN = 2

  AGENT_TYPES = {
    AGENT => 'Agente',
    ADMIN => 'Administrador'
  }

  STATUS_TEXT = {
    STATUS_ACTIVE => 'Activo',
    STATUS_INACTIVE => 'Inactivo'
  }

  def status_text
    STATUS_TEXT[status]
  end

  def type_text 
    AGENT_TYPES[agent_type]
  end

  def full_name
  	person.full_name
  end


  def picture_url
  	person.picture_url
  end
end
