class Loan < ApplicationRecord
  belongs_to :item
  belongs_to :person
  has_many :activity_logs, as: :element
  belongs_to :loaned_by_user, foreign_key: "loaned_by", class_name: "Person"
  belongs_to :received_by_user, foreign_key: "received_by", class_name: "Person",  optional: true

  
  LOANED = 1
  RETURNED = 2

  STATUS_TEXT = {
    LOANED => 'Prestado',
    RETURNED => 'Regresado'
  }

  def status_text
    STATUS_TEXT[status]
  end
end
