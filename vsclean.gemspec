# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'info'

Gem::Specification.new do |spec|
  spec.name          = VsClean::NAME
  spec.version       = VsClean::VERSION
  spec.authors       = ["Michaël Fortin"]
  spec.email         = ["fortinmike@irradiated.net"]

  spec.summary       = VsClean::DESCRIPTION
  spec.homepage      = "https://github.com/fortinmike/vsclean"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_runtime_dependency "claide", "~> 0.8", ">= 0.8.0"
  spec.add_runtime_dependency "colored", "~> 1.2"
  
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
