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
    ra_events_page = Nokogiri::HTML(open(url))
    
    events = []
    events << {no_events_listed: true} if self.is_real_event?(ra_events_page)
    
    ra_events_page.css("#items").each do |event_listings|
      event_listings.css('li').each do |event|
        event_date = event.css('time').text
        event_title = event.css('div h1 a').text.gsub("#{event.css('span a').text}", "")
        event_location = event.css('span a[1]').text + " " + event.css('a[2]').text unless event.css('span a').text.empty?
        event_artists = event.css('div div').text unless event.css('div div').text.empty?
        event_url = event.css('a').attr('href').text

        if event_title != "" && event_location != ""  
          events << {date: event_date, title: event_title, location: event_location, artists: event_artists, url: event_url}         
        end
      end
    end

    events
  end

  def self.is_real_event?(ra_events_page)
    ra_events_page.css('.pr8').first.text.include?("no events")
  end

end
