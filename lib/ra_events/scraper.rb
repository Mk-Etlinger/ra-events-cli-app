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
    events << {no_events_listed: true} if ra_events_page.css('.pr8').first.text.include?("no events")
    ra_events_page.css("#items").each do |event_listing|
      
      event_listing.css('li').each do |date|
        event_date = date.css('time').text
        event_title = date.css('div h1 a').text.gsub("#{date.css('span a').text}", "")
        event_location = date.css('span a[1]').text + " " + date.css('a[2]').text unless date.css('span a').text.empty?
        event_artists = date.css('div div').text unless date.css('div div').text.empty?
        event_url = date.css('a').attr('href').text

        events << {date: event_date, title: event_title, location: event_location, artists: event_artists, url: event_url}          
      end

    end
    events.compact
  end

end
