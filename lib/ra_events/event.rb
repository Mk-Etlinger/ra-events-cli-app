require 'pry'

class Event

  attr_accessor :date, :title, :location, :artists, :url, :no_events_listed

  @@all = []

  def initialize(event_hash) 
    event_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    @@all << self
  end
  

   def self.create_from_collection(events_array)
    events_array.each do |event_hash|
      Event.new(event_hash)
    end
  end

  def self.all
    @@all
  end
end
