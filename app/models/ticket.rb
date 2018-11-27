class Ticket < ApplicationRecord
  after_create :set_extra

  def set_extra
    con = Ticket.where("EXTRACT(YEAR FROM created_at) = :year", {:year => Date.today.year}).maximum('consecutive')
    if con.nil?
      con = 1
    else
      con += 1
    end
    consecutivo = "%04d" % con
    self.consecutive = con
    year = Date.today.year.to_s.last(2)
    self.identificator = "#{year}/#{consecutivo}"
    self.save(:validate => false)
  end
end
