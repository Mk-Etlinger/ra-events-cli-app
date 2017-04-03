require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper

  attr_accessor 

  def initialize

  end
  
  def self.scrape_links(index_url)
    state_event_page_url = {}
    ra_events_page = Nokogiri::HTML(open("https://www.residentadvisor.net/events.aspx"))

    ra_events_page.css("li.parent a").each do |e|
      state_event_page_url[e.children.text] = e['href'] unless e.children.text == "Washington DC"
    end

    state_event_page_url
  end

  def self.scrape_events_page(url)

    ra_events_page = Nokogiri::HTML(open("https://www.residentadvisor.net/events.aspx"))

    events = []
    ra_events_page.css(".col4").each do |e|
      e.css(".bbox").each do |e|
        event_title = e.css('a').text
        event_location = e.css('span').text
        event_artists = e.css('div').text if !e.css('div').text.empty?
        event_url = e.css('a').attribute('href').text

        events << {title: event_title, location: event_location, artists: event_artists, url: event_url}
      end
    end
    events
    binding.pry
  end

end


#This will grab the Date of all of the listed shows

# ra_events_page.css("#event-listing .date").each do |e|
#   puts "#{e.css('a').first.text}"
# end

