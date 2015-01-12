# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_support/fiscal_dates/version'

Gem::Specification.new do |spec|
  spec.name          = "activesupport-fiscal_dates"
  spec.version       = ActiveSupport::FiscalDates::VERSION
  spec.authors       = ["Kinesis Pty Ltd"]
  spec.email         = ["devs@kinesis.org"]
  spec.summary       = %q{Adds fiscal date support}
  spec.description   = %q{Adds fiscal date support}
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"

  spec.add_dependency "activesupport", ">= 4.1.0"
end
