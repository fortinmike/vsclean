require "claide"
require "info"
require "console"
require "fileutils"

module BinClean
  class Clean < CLAide::Command
    self.command = "binclean"
    self.version = BinClean::VERSION
    self.description = BinClean::DESCRIPTION
    
    def initialize(argv)
      super
    end
    
    def run
      # Delete bin and obj directories
      paths = Dir.glob("**/{bin,obj}").select { |f| File.directory?(f) }
      
      # Delete .suo files (can cause Intellisense errors, among other things)
      paths.push(*Dir.glob("**/.vs/**/.suo"))
      
      if paths.none?
        Console.log_step("All is well with the world... nothing to clean!")
        return
      end
        
      Console.log_step("Cleaning...") 
      
      paths.each { |d| delete(d) }
      
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