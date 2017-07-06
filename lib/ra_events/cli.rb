require 'pry'

class RaEvents::CLI

STATES_AND_LINKS = {"AL"=>"/events.aspx?ai=108", "AK"=>"/events.aspx?ai=109", "AZ"=>"/events.aspx?ai=102", "AR"=>"/events.aspx?ai=110", "CA"=>"/events.aspx?ai=308", "CO"=>"/events.aspx?ai=82", "CT"=>"/events.aspx?ai=111", "DE"=>"/events.aspx?ai=112", "DC"=>"District of Columbia", "FL"=>"/events.aspx?ai=317", "GA"=>"/events.aspx?ai=64", "HI"=>"/events.aspx?ai=133", "ID"=>"/events.aspx?ai=113", "IL"=>"/events.aspx?ai=359", "IN"=>"/events.aspx?ai=85", "IA"=>"/events.aspx?ai=114", "KS"=>"/events.aspx?ai=90", "KY"=>"/events.aspx?ai=115", "LA"=>"/events.aspx?ai=65", "ME"=>"/events.aspx?ai=116", "MD"=>"/events.aspx?ai=117", "MA"=>"/events.aspx?ai=79", "MI"=>"/events.aspx?ai=360", "MN"=>"/events.aspx?ai=81", "MS"=>"/events.aspx?ai=103", "MO"=>"/events.aspx?ai=118", "MT"=>"/events.aspx?ai=119", "NE"=>"/events.aspx?ai=120", "NV"=>"/events.aspx?ai=47", "NH"=>"/events.aspx?ai=121", "NJ"=>"/events.aspx?ai=48", "NM"=>"/events.aspx?ai=122", "NY"=>"/events.aspx?ai=8", "NC"=>"/events.aspx?ai=123", "ND"=>"/events.aspx?ai=124", "OH"=>"/events.aspx?ai=84", "OK"=>"/events.aspx?ai=104", "OR"=>"/events.aspx?ai=125", "PA"=>"/events.aspx?ai=80", "RI"=>"/events.aspx?ai=127", "SC"=>"/events.aspx?ai=105", "SD"=>"/events.aspx?ai=128", "TN"=>"/events.aspx?ai=72", "TX"=>"/events.aspx?ai=318", "UT"=>"/events.aspx?ai=106", "VT"=>"/events.aspx?ai=129", "VA"=>"/events.aspx?ai=130", "WA"=>"Washington", "WV"=>"/events.aspx?ai=131", "WI"=>"/events.aspx?ai=107", "WY"=>"/events.aspx?ai=132"}
URL_BASE = "https://www.residentadvisor.net"

  def call
    welcome
    list_events
    goto_event_url
  end

  def welcome
    puts "Welcome to ra_events! A gem that lists electronic music events."
  end

  def user_inputs_state
    prompt_for_state
    input = gets.strip.upcase
    if STATES_AND_LINKS.key?(input)
      url = URL_BASE + STATES_AND_LINKS[input]
    else
      puts "Invalid"
      user_inputs_state
    end
  end

  def list_events
    display_events_this_week_text
    scrape_events

    Event.all.each.with_index(1) do |event, i|      
      if event.no_events_listed == true
        no_events_listed_message
        clear_events
        call
      else
        display_and_format_event(event, i)
      end
    end
  end

  def goto_event_url
    prompt_for_event_menu_or_exit
    input = gets.strip.downcase
      
      if input.to_i > 0 && input.to_i <= Event.all.count
        event = Event.all[input.to_i - 1]
        print_url(event)
        open_url_in_browser(event)
        goto_event_url
      elsif input == "exit"
        exit_program
      elsif input == "menu"
        clear_events
        main_menu
      else
        puts "Invalid"
        goto_event_url
      end
  end

  def main_menu
    call
  end

  def display_events_this_week_text
    puts "Events this week:"
    puts "****************"
    puts "*************"
    puts "**********"
    puts "*******"
    puts "****"
    puts "**"
  end

  def exit_program
    clear_events
    puts "Bye, see you on the dance floor!"
    exit
  end

  def clear_events
    Event.clear
  end

  def scrape_events
    events_by_month = Scraper.scrape_events_page(user_inputs_state)
    Event.create_from_collection(events_by_month)
  end

  def prompt_for_state
    puts "Please enter your state(ex: MI, NY, CA):"
  end

  def no_events_listed_message
    puts "There are currently no events listed for this month in this region."
    puts
  end

  def display_and_format_event(event, i)
    puts "#{i}. #{event.title} "
    puts "Location: #{event.location} " unless event.artists.nil?
    puts "Artists: #{event.artists}" unless event.artists.nil?
    puts "Date: #{event.date.gsub("T00:00", "")}" 
    puts 
  end
  
  def prompt_for_event_menu_or_exit
    puts "Type the event # you'd like to view in your browser, 'menu' or 'exit':"
  end  
  
  def print_url(event)
    puts "Opening residentadvisor.net..."
    puts "#{URL_BASE + event.url}"
  end

  def open_url_in_browser(event)
  `open #{URL_BASE + event.url}`
  end
  
  
end



