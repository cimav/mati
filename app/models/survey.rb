class Survey < ApplicationRecord
  belongs_to :ticket

  def survey_url
  	"http://soporte.cimav.edu.mx/encuesta/#{self.token}"
  end

end
