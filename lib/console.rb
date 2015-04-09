require "colored"

module BinClean
  class Console
    def self.log_step(message)
      print_arrow
      puts $stdout.isatty ? message.bold.green : message
    end
    
    def self.log_substep(message)
      print_arrow
      puts $stdout.isatty ? message.blue : message
    end
    
    def self.log_info(message)
      print_arrow
      puts $stdout.isatty ? message.white : message
    end
    
    def self.log_warning(message)
      print_arrow
      puts $stdout.isatty ? message.yellow : message
    end
    
    def self.log_error(message)
      print_arrow
      puts $stdout.isatty ? message.red : message
    end
    
    def self.ask_yes_no(message)
      answered = false
      while !answered
        print_arrow
        print message
        print " (y/n) "
        
        case $stdin.gets.strip.downcase
        when "y", "yes"
          answered = true
          return true
        when "n", "no"
          answered = true
          return false
        end
      end
    end
    
    def self.print_arrow
      print $stdout.isatty ? "> ".white : ""
    end
  end
end