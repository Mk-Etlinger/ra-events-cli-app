require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper

  attr_accessor 

  def initialize

  end
  
  def self.scrape_links(index_url)
    states_with_link = {}
    ra_events_page = Nokogiri::HTML(open("https://www.residentadvisor.net/events.aspx"))

    ra_events_page.css("li.parent a").each do |e|
      states_with_link[e.children.text] = e['href'] unless e.children.text == "Washington DC"
    end

    states_with_link
  end

  def self.scrape_events_page(url)

    ra_events_page = Nokogiri::HTML(open("https://www.residentadvisor.net/events.aspx"))

    ra_events_page.css(".col4").each do |e|
      puts "#{e.css(".date").first.text}
      ***********************
      ******************
      ***********
      *******
      ***
      *"
      binding.pry
      # e.css('.bbox').each do |e|
      #   puts "Title: #{e.css('a').text}"
      #   puts "Location: #{e.css('span').text}"
      #   puts "Artists: #{e.css('div').text}" if !e.css('div').text.empty?
      #   puts "Url: #{e.css('a').attribute('href').text}"
      #   puts ""
      # end
    
    end
  end

end


#This will grab the Date of all of the listed shows

# ra_events_page.css("#event-listing .date").each do |e|
#   puts "#{e.css('a').first.text}"
# end
