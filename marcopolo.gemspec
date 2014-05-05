# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'marcopolo/version'

Gem::Specification.new do |spec|
  spec.name          = "marcopolo"
  spec.version       = Marcopolo::VERSION
  spec.authors       = ["Andrew Hammond"]
  spec.email         = ["andrew@evertrue.com"]
  spec.summary       = %q{Log raw HTTP requests & responses}
  spec.description   = %q{Log raw HTTP requests & responses}
  spec.homepage      = "http://github.com/andrhamm"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
