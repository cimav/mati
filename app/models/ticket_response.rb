class TicketResponse < ApplicationRecord
  belongs_to :to, :foreign_key => "to", :class_name => "Person"
  belongs_to :from, :foreign_key => "from", :class_name => "Person"
  belongs_to :ticket
end
