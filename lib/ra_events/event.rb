class Event

  attr_accessor :title, :location, :artists, :url, :ticket_price

  def initialize 

  end

  def self.this_week
    event_1 = self.new

    event_1.title = "Nicky Siano's Native New Yorker B'day Plus Nancy Whang and Jayson Green"

    event_1.location = "Good Room"

    event_1.artists = "Nicky Siano's, Nancy Whang, and Jayson Geen"

    event_1.url = "https://www.residentadvisor.net/event.aspx?933212"


    event_2 = self.new

    event_2.title = "Blkmarket Membership presents Bill Patrick's Birthday"

    event_2.location = "Analog Bkny"

    event_2.artists = "Bill Patrick, Taimur & Fahad"

    event_2.url = "https://www.residentadvisor.net/event.aspx?933212"

    [event_1, event_2]
  end



end
