class Event

  attr_accessor :title, :location, :artists, :url

  @@all = []

  def initialize(event_hash) 
    event_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    @@all << self
  end
  

   def self.create_from_collection(events_array)
    events_array.each do |event_hash|
      Student.new(event_hash)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |attr, value|
      self.send("#{attr}=", value)
    end
    self
  end

  def self.all
    @@all
  end
end
