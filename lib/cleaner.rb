require "console"

module BinClean
  class Cleaner
    def self.run
      directories = Dir.glob("**/{bin,obj}").select { |f| File.directory?(f) }
      puts directories.inspect
    end
  end
end