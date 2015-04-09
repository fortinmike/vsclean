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
      puts directories.inspect
    end
  end
end