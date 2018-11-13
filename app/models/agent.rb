class Agent < ApplicationRecord
  belongs_to :person
  def full_name
  	person.full_name
  end
  def picture_url
  	person.picture_url
  end
end
