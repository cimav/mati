class Person < ApplicationRecord
  def full_name
  	first_name + ' ' + last_name
  end

  def picture_url
    "http://cimav.edu.mx/foto/#{email.split('@')[0]}/64"
  end
end
