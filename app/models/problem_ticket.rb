class ProblemTicket < ApplicationRecord
  belongs_to :problem 
  belongs_to :ticket
end
