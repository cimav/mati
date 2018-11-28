class Agent < ApplicationRecord
  belongs_to :person
  has_many :tickets


  STATUS_ACTIVE = 1
  STATUS_INACTIVE = 2


  def full_name
  	person.full_name
  end
  def picture_url
  	person.picture_url
  end
end
