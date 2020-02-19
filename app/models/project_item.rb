class ProjectItem < ApplicationRecord
  belongs_to :project 
  belongs_to :item
end
