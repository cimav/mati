class Ticket < ApplicationRecord

  has_many :activity_logs, as: :element
  has_many :attachments, as: :element
  has_many :ticket_items
  has_many :ticket_responses
  has_many :problem_tickets
  has_many :change_tickets
  has_many :surveys

  belongs_to :agent
  belongs_to :person, optional: true
  belongs_to :created_by, :foreign_key => "created_by", :class_name => "Person"
  belongs_to :service

  after_create :set_extra


  HIGH   = 3
  MEDIUM = 2
  LOW    = 1

  PRIORITIES = {
    LOW    => 'Baja',    
    MEDIUM => 'Media', 
    HIGH   => 'Alta'
  }

  STATUS_OPEN = 1
  STATUS_CLOSED = 99
  STATUS_PENDING = 2
  STATUS_CANCELED = 3
  

  STATUS_TEXT = {
    STATUS_OPEN => 'Abierto',
    STATUS_CLOSED => 'Cerrado',
    STATUS_PENDING => 'En espera / Pendiente',
    STATUS_CANCELED => 'Cancelado'
  }

  FIELDS = {
    'agent_id' => 'Agente',
    'people_id' => 'Solicitante',
    'description' => 'Descripción',
    'status' => 'Estado',
    'priority' => 'Prioridad'
  }

  def status_text
    STATUS_TEXT[status]
  end

  def status_color
    c = 'red' if status == STATUS_CANCELED
    c = 'blue' if status == STATUS_OPEN
    c = 'green lighten-1' if status == STATUS_CLOSED
    c = 'amber' if status == STATUS_PENDING
    c
  end

  def priority_text
    PRIORITIES[priority]
  end

  def set_extra
    con = Ticket.where("EXTRACT(YEAR FROM created_at) = :year", {:year => Date.today.year}).maximum('consecutive')
    if con.nil?
      con = 1
    else
      con += 1
    end
    consecutivo = "%04d" % con
    self.consecutive = con
    year = Date.today.year.to_s.last(2)
    self.identificator = "#{year}/#{consecutivo}"
    self.save(:validate => false)
  end


  def field_text(f)
    if FIELDS[f]
      v = FIELDS[f]
    else 
      v = f
    end
    return v 
  end
end
