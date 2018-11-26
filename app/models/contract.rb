class Contract < ApplicationRecord
  belongs_to :contract_type, optional: true
  has_many :contract_items
  has_many :activity_logs, as: :element
  has_many :attachments, as: :element



  ACTIVE = 1
  FINISHED = 2
  CANCELED = 3

  STATUS_TEXT = {
  	ACTIVE   => 'Activo',
  	FINISHED => 'Finalizado',
  	CANCELED => 'Cancelado'
  }

  FIELDS = {
    'name' => 'Nombre',
    'number' => 'Identificador',
    'contract_type_id' => 'Tipo',
    'description' => 'Descripción',
    'start_date' => 'Fecha inicio',
    'end_date' => 'Fecha termino',
    'notify_days' => 'Días de notificación',
    'notify_to' => 'Notificar a',
    'cost' => 'Costo',
    'status' => 'Estado'
  }

  def field_text(f)
    if FIELDS[f]
      v = FIELDS[f]
    else 
      v = f
    end
    return v 
  end

  def status_text
    STATUS_TEXT[status]
  end

  def days
  	((end_date - start_date).to_i) / 86400
  end

  def transcurred
  	((Time.now - start_date).to_i) / 86400
  end

  
end
