# encoding: UTF-8

require 'rubygems'
require 'rspec'
require 'vcr'

$:.unshift File.expand_path('../../lib', __FILE__)

require 'adswizz_api_wrapper'


VCR.config do |c|
  c.cassette_library_dir     = 'spec/cassettes'
  c.hook_into                :webmock
  c.default_cassette_options = { record: :new_episodes }
end

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end
