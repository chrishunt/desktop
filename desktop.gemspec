# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'desktop/version'

Gem::Specification.new do |spec|
  spec.name          = "desktop"
  spec.version       = Desktop::VERSION
  spec.authors       = ["Chris Hunt"]
  spec.email         = ["c@chrishunt.co"]
  spec.summary       = %q{A decent way to change your desktop image}
  spec.description   = %q{A decent way to change your desktop image}
  spec.homepage      = "https://github.com/chrishunt/desktop"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday",  "~> 0.9.1"
  spec.add_dependency "sqlite3",  "~> 1.3"
  spec.add_dependency "thor",     "~> 0.19"

  spec.add_development_dependency "bundler",  "~> 1.7.1"
  spec.add_development_dependency "minitest", "~> 5.5.1"
  spec.add_development_dependency "pry",      "~> 0.10.1"
  spec.add_development_dependency "rake",     "~> 10.4.2"
  spec.add_development_dependency "vcr",      "~> 2.9"
  spec.add_development_dependency "webmock",  "~> 1.18"
end
