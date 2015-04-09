# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'info'

Gem::Specification.new do |spec|
  spec.name          = Binclean::NAME
  spec.version       = Binclean::VERSION
  spec.authors       = ["Michaël Fortin"]
  spec.email         = ["fortinmike@irradiated.net"]

  spec.summary       = %q{Recursively delete temporary Visual Studio output files from the current directory}
  spec.homepage      = "https://github.com/fortinmike/binclean"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
