require "spec_helper"

describe "Scraper" do

  let!(:events_array) {[{:title=>"718 Sessions - Danny Krivit (45' Birthday Set) at OutputOutput",
                                :location=>"at Output75", :artists=>"Output, Danny Krivit",:url=>"/event.aspx?947816"},
                               {:title=>"Bushwick A/V Sunday Showcase - Frequencies with Sleepy Boo & MoreStudio 299", 
                                :location=>"at Studio 29915",:artists=>"Sleepy & Boo, Luka Tacon, Alex Cecil, Nicholas..",
                                :url=>"/event.aspx?952516"}]}

  let!(:student_joe_hash) {{:twitter=>"https://twitter.com/jmburges",
                            :linkedin=>"https://www.linkedin.com/in/jmburges",
                            :github=>"https://github.com/jmburges",
                            :blog=>"http://joemburgess.com/",
                            :profile_quote=>"\"Reduce to a previously solved problem\"",
                            :bio=>
  "I grew up outside of the Washington DC (NoVA!) and went to college at Carnegie Mellon University in Pittsburgh. After college, I worked as an Oracle consultant for IBM for a bit and now I teach here at The Flatiron School."}}

  let!(:student_david_hash) {{:linkedin=>"https://www.linkedin.com/in/david-kim-38221690",
 :github=>"https://github.com/davdkm",
 :profile_quote=>
  "\"Yeah, well, you know, that's just, like, your opinion, man.\" - The Dude",
 :bio=>
  "I'm a southern California native seeking to find work as a full stack web developer. I enjoying tinkering with computers and learning new things!"}}

  describe "#scrape_links" do
    it "is a class method that scrapes the student index page and a returns an array of hashes in which each hash represents one student" do
      index_url = "https://www.residentadvisor.net/events.aspx"
      scraped_students = Scraper.scrape_links(index_url)
      expect(scraped_students).to be_a(Hash)
      expect(scraped_students.first).to have_key(:location)
      expect(scraped_students.first).to have_key(:name)
      expect(scraped_students).to include(events_array[0], events_array[1], events_array[2])
    end
  end

  describe "#scrape_events_page" do
    it "is a class method that scrapes a student's profile page and returns a hash of attributes describing an individual student" do
      profile_url = "https://www.residentadvisor.net/events.aspx"
      scraped_student = Scraper.scrape_events_page(profile_url)
      expect(scraped_student).to be_a(Hash)
      expect(scraped_student).to match(student_joe_hash)
    end

    it "can handle profile pages without all of the social links" do
      profile_url = "https://www.residentadvisor.net/events.aspx"
      scraped_student = Scraper.scrape_events_page(profile_url)
      expect(scraped_student).to be_a(Hash)
      expect(scraped_student).to match(student_david_hash)
    end
  end
end
