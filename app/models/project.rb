class Project < ApplicationRecord
  has_many :activity_logs, as: :element
  has_many :attachments, as: :element
  has_many :project_items
  has_many :project_tickets
  has_many :project_problems
  has_many :project_changes
  has_many :project_tasks

  belongs_to :agent
  belongs_to :person, optional: true

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
    'start_date_planned' => 'Fecha de inicio planeada',
    'end_date_planned' => 'Fecha de termino planeada',
    'start_date_real' => 'Fecha de inicio real',
    'end_date_real' => 'Fecha de termino real',
    'status' => 'Estado',
    'priority' => 'Prioridad'
  }


  def status_text
    STATUS_TEXT[status]
  end

  def priority_color
    c = 'red' if priority == HIGH
    c = 'blue' if priority == LOW
    c = 'amber' if priority == MEDIUM
    c
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
    con = Project.where("EXTRACT(YEAR FROM created_at) = :year", {:year => Date.today.year}).maximum('consecutive')
    if con.nil?
      con = 1
    else
      con += 1
    end
    consecutivo = "%04d" % con
    self.consecutive = con
    year = Date.today.year.to_s.last(2)
    self.identificator = "PROY-#{year}/#{consecutivo}"
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
