require "claide"
require "info"
require "console"
require "fileutils"

module VsClean
  class Mode
    LOCAL = 0
    GLOBAL = 1
    FULL = 2
  end

  class Command < CLAide::Command
    self.command = "vsclean"
    self.version = VsClean::VERSION
    self.description = VsClean::DESCRIPTION
    
    def self.options
      [
        ['[--full]', 'Delete local and global temporary files'],
        ['[--global]', 'Delete global caches and temporary files'],
        ['[--dry-run]', 'Simulate deletion (list all files and directories that would be deleted)']
      ].concat(super)
    end
    
    def initialize(argv)
      @dryrun = argv.flag?("dry-run")
      
      @mode = Mode::LOCAL
      @mode = Mode::GLOBAL if argv.flag?("global")
      @mode = Mode::FULL if argv.flag?("full")
      
      super
    end
    
    def run
      paths = case @mode
      when Mode::LOCAL; collect_global_paths
      when Mode::GLOBAL; collect_global_paths
      when Mode::FULL; collect_global_paths.push(*collect_local_paths)
      end
      
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
      paths.push(*Dir.glob(home + "/AppData/Microsoft/WebsiteCache"))
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