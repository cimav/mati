class ProjectTask < ApplicationRecord
  belongs_to :project 
  belongs_to :agent

  TODO  = 1
  DOING = 2
  DONE  = 3
end
