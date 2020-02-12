class TicketMailer < ApplicationMailer
  def ticket_closed(ticket)
    @ticket = ticket
    @url  = 'http://example.com/login'
    mail(to: @ticket.person.email, subject: "[Soporte Técnico] Ticket ##{@ticket.identificator} cerrado.")
  end
end