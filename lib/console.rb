require "colored"

module VsClean
  class Console
    def self.log_step(message)
      print_arrow
      puts message.bold.green + "\r"
    end
    
    def self.log_substep(message)
      print_arrow
      puts message.blue + "\r"
    end
    
    def self.log_info(message)
      print_arrow
      puts message.white + "\r"
    end
    
    def self.log_warning(message)
      print_arrow
      puts message.yellow + "\r"
    end
    
    def self.log_error(message)
      print_arrow
      puts message.red + "\r"
    end
    
    def self.print_arrow
      print $stdout.isatty ? "> ".white : ""
    end
  end
end