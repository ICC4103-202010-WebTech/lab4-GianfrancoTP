class Ticket < ApplicationRecord
  belongs_to :order
  belongs_to :ticket_type

  # TODO: complete the folowing
  after_save :update_stats
  after_destroy :delete_ticket

  def update_stats
    es = self.ticket_type.event.event_stat
    es.attendance += 1
    es.tickets_sold += 1
    es.save
    if self.ticket_type.event.event_venue.capacity < es.attendance
      logger.debug("Capacity is full! sorry to late")
      self.destroy
    end
  end

  def delete_ticket
    self.ticket_type.event.event_stat.attendance -= 1
    self.ticket_type.event.event_stat.tickets_sold -= 1
    self.ticket_type.event.event_stat.save
  end
end
