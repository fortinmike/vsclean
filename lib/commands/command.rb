require "claide"
require "info"
require "console"
require "fileutils"

module VsClean
  class Command < CLAide::Command
    self.command = "vsclean"
    self.version = VsClean::VERSION
    self.description = VsClean::DESCRIPTION
    
    def self.options
      [
        ['[--global]', 'Delete global caches and temporary files'],
        ['[--dry-run]', 'Simulate deletion (list all files and directories that would be deleted)']
      ].concat(super)
    end
    
    def initialize(argv)
      @dryrun = argv.flag?("dry-run")
      @global = argv.flag?("global")
      super
    end
    
    def run
      paths = @global ? collect_global_paths : collect_local_paths
      
      if paths.none?
        Console.log_step("All good... nothing to clean!")
        return
      end
        
      Console.log_step("Cleaning...") 
      paths.each { |d| @dryrun ? simulate_delete(d) : delete(d) }
      Console.log_step("Done!")
    end
    
    def collect_global_paths
      home = File.expand_path("~")
      paths = Dir.glob(home + "/AppData/Local/JetBrains/**/SolutionCaches").select { |f| File.directory?(f) }
      paths.push(home + "/AppData/Microsoft/WebsiteCache")
      paths.push(*Dir.glob(home + "/AppData/Local/Microsoft/**/ComponentModelCache"))
    end
    
    def collect_local_paths
      # bin and obj directories
      paths = Dir.glob("**/{bin,obj}").select { |f| File.directory?(f) }
      
      # .suo files (can cause Intellisense errors, solution load issues and more)
      paths.push(*Dir.glob("**/.vs/**/.suo"))
    end
    
    def simulate_delete(path)
      Console.log_substep("Would delete '#{path}'")
    end
    
    def delete(path)
      FileUtils.rm_r(path)
      Console.log_substep("Deleted '#{path}'")
    rescue StandardError => e
      Console.log_error("Could not delete '#{path}': #{e.message}")
    end
  end
end