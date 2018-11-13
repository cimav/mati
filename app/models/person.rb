class Person < ApplicationRecord

  STATUS_ACTIVE = 1
  STATUS_INACTIVE = 2

  def full_name
  	first_name + ' ' + last_name
  end

  def picture_url
    "http://cimav.edu.mx/foto/#{email.split('@')[0]}/64"
  end
end
