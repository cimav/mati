class ChangeTicket < ApplicationRecord
  belongs_to :change 
  belongs_to :ticket
end
