class ProjectTicket < ApplicationRecord
  belongs_to :project 
  belongs_to :ticket
end
