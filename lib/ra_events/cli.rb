class RaEvents::CLI

  def call
    puts "Events this week:"
    list_events(user_inputs_state)
    goto_website
    exit_program
  end

  def user_inputs_state
    puts "Please enter your state:"
    input = gets.strip
  end

  def list_events(user_input)
    if user_input
      puts <<-DOC
      * US New York By week
      Fri, 31 Mar 2017 /

        1. Nicky Siano's Native New Yorker B'day Plus Nancy Whang and Jayson Green
        at Good Room
        Nicky Siano's Native New Yorker Bday Extravaga..

        2. Blkmarket Membership presents Bill Patrick's Birthday
        at Analog Bkny
        Bill Patrick, Taimur & Fahad
        
        DOC
    end
  end

  def goto_website
    puts "Type goto ra to open events page in your browser or type exit:"
    input = nil
    while input != "exit"
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
