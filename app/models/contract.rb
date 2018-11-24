class Contract < ApplicationRecord
  belongs_to :contract_type, optional: true
  has_many :contract_items
  has_many :activity_logs, as: :element


  ACTIVE = 1
  FINISHED = 2
  CANCELED = 3

  STATUS_TEXT = {
  	ACTIVE   => 'Activo',
  	FINISHED => 'Finalizado',
  	CANCELED => 'Cancelado'
  }

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
