class Survey < ApplicationRecord
  belongs_to :ticket

  def survey_url
  	if Rails.env.production? 
      host = "http://mati.cimav.edu.mx"
  	else 
  	  host = "http://localhost:3000"	
  	end
  	"#{host}/encuesta/#{self.token}"
  end

end
