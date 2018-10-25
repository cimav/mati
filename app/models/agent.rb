class Agent < ApplicationRecord
  belongs_to :person
  def full_name
  	person.full_name
  end
end
