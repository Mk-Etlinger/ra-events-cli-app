require "spec_helper"

describe "Student" do
  let!(:events_array) {[{:title=>"718 Sessions - Danny Krivit (45' Birthday Set) at OutputOutput",
                         :location=>"at Output75", :artists=>"Output, Danny Krivit",:url=>"/event.aspx?947816"},
                        {:title=>"Bushwick A/V Sunday Showcase - Frequencies with Sleepy Boo & MoreStudio 299", 
                         :location=>"at Studio 29915",:artists=>"Sleepy & Boo, Luka Tacon, Alex Cecil, Nicholas..",
                          :url=>"/event.aspx?952516"}]}


  let!(:student) {Event.new({:name=>"Alex Patriquin", :location=>"New York, NY"})}

  after(:each) do
    Event.class_variable_set(:@@all, [])
  end
  
  describe "#new" do
    it "takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash." do
      expect{Event.new({:name => "Sophie DeBenedetto", :location => "Brooklyn, NY"})}.to_not raise_error
      expect(student.name).to eq("Alex Patriquin")
      expect(student.location).to eq("New York, NY")
    end

    it "adds that new student to the Student class' collection of all existing students, stored in the `@@all` class variable." do
      expect(Event.class_variable_get(:@@all).first.name).to eq("Alex Patriquin")
    end
  end

  describe ".create_from_collection" do
    it "uses the Scraper class to create new students with the correct name and location." do
      Event.class_variable_set(:@@all, [])
      Event.create_from_collection(events_array)
      expect(Event.class_variable_get(:@@all).first.name).to eq("Alex Patriquin")
    end
  end

  describe '.all' do
    it 'returns the class variable @@all' do
      Event.class_variable_set(:@@all, [])
      expect(Event.all).to match_array([])
    end
  end
end