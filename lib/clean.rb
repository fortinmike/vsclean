require "claide"
require "info"
require "console"

module BinClean
  class Clean < CLAide::Command
    self.command = "binclean"
    self.version = BinClean::VERSION
    self.description = BinClean::DESCRIPTION
    
    def initialize(argv)
      super
    end
    
    def run
      directories = Dir.glob("**/{bin,obj}").select { |f| File.directory?(f) }
      
      if directories.none?
        Console.log_step("All is well with the world... nothing to clean!")
        return
      end
        
      Console.log_step("Cleaning...") 
      
      directories.each { |d| delete(d) }
      
      Console.log_step("Done!")
    end
    
    def delete(path)
      FileUtils.rm_r(path)
      Console.log_substep("Deleted ./#{path}")
    rescue StandardError => e
      Console.log_error("Could not delete './#{path}': #{e.message}")
    end
  end
end