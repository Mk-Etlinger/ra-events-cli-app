require 'pry'

class RaEvents::CLI

  def call
    list_events(user_inputs_state)
    goto_website
    exit_program
  end

  def user_inputs_state
    puts "Please enter your state:"
    input = gets.strip
    puts "Events this week:"
    @event = Event.this_week
    # binding.pry
    @event.each.with_index(1) do |event, i|
      puts "#{i}. #{event.title} 
      Location: #{event.location} 
      Artists: #{event.artists}
      URL: #{event.url}"
    end

  end

  def list_events(user_input)
    if user_input
      
    end
  end

  def goto_website
    input = nil
    while input != "exit"
      puts "Type goto ra to open events page in your browser or type exit:"
      input = gets.strip
      if input == "goto ra"
        puts "Opening residentadvisor.net..."
      end
    end
  end

  def exit_program
    puts "Goodbye!"
  end

end
