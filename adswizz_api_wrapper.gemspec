# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adswizz_api_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = "adswizz_api_wrapper"
  spec.version       = AdswizzApiWrapper::VERSION
  spec.authors       = ["luki3k5"]
  spec.email         = ["luki3k5@gmail.com"]
  spec.description   = %q{This gem allows to talk to AdsWizz API for obtaining ads.}
  spec.summary       = %q{This gem allows to talk to AdsWizz API for obtaining ads.}
  spec.homepage      = "http://adswizz.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'vast'
end
