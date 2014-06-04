# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'transliterate_ga/version'

Gem::Specification.new do |spec|
  spec.name          = "transliterate_ga"
  spec.version       = TransliterateGa::VERSION
  spec.authors       = ["Countculture"]
  spec.email         = ["countculture@gmail.com"]
  spec.description   = %q{Library for transliterating Georgian alphabet. This is just a gem wrapper for https://github.com/tigeorgia/georgian-language-toolkit.git by Transparency International Georgia}
  spec.summary       = %q{Georgian alphabet transliterater}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "debugger"

end
