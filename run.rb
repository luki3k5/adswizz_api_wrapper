#!/Users/luki3k5/.rvm/rubies/ruby-2.0.0-p247/bin/ruby

require 'rubygems'
require 'vast'
require 'faraday'
require_relative './ad'

def build_uri(req_type, protocol_ver=PROTOCOL_VER, zone_id=ZONE_ID)
  "/www/delivery/swfIndex.php?reqType=#{REQUEST_TYPE}&protocolVersion=#{protocol_ver}&zoneId=#{zone_id}"
end

########## CONSTANTS #########

BASE_URL     = 'http://demo.adswizz.com'
ZONE_ID      = '2409'
REQUEST_TYPE = 'AdsSetup'
PROTOCOL_VER = 2.0 

########## LOGIN IN #########

conn = Faraday.new( url: BASE_URL) do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

########## STARTING TO OBTAIN STUFFF #########

response = conn.get(build_uri(REQUEST_TYPE))
document = VAST::Document.parse(response.body)
document.inline_ads.each { |ad| Ad.new(ad) }
