class TicketMailer < ApplicationMailer
  def ticket_closed(ticket, survey, msg)
    @ticket = ticket
    @survey = survey
    @msg = msg
    mail(to: @ticket.person.email, subject: "[Soporte Técnico] Ticket Resuelto ##{@ticket.identificator}.")
  end
  def ticket_open(ticket)
    @ticket = ticket
    mail(to: @ticket.person.email, subject: "[Soporte Técnico] Ticket Recibido ##{@ticket.identificator}.")
  end
  def ticket_assigned(ticket)
    @ticket = ticket
    mail(to: @ticket.agent.email, subject: "[Soporte Técnico] Ticket Asignado ##{@ticket.identificator}.")
  end
end