class TicketMailer < ApplicationMailer
  def ticket_closed(ticket, survey, msg)
  	puts "Ticket mailer ---------------------"
    @ticket = ticket
    @survey = survey
    @msg = msg
    mail(to: @ticket.person.email, subject: "[Soporte Técnico] Ticket Resuelto ##{@ticket.identificator}.")
  end
end