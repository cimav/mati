class Department < ApplicationRecord
  belongs_to :person
  has_many :members, :foreign_key => "department_id", :class_name => "Person"

end
