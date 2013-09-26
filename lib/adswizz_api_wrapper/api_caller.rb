class ApiCaller 
  attr_accessor :faraday  

  PROTOCOL_VERSION = 2.0
  BASE_URL         = 'adswizz.com' 
  REUEST_TYPES     = {
    m1: 'AdsSetup',
    m2: 'AdsDisplayStarted',
    m3: 'AdsSendReport',
    m4: 'AdsDisplayEnd',
    m5: 'AdsClicked',
    m6: 'AdsPreviewStarted',
    m7: 'PreviewClicked',
    m8: 'LikeClicked',
    m9: 'ShareClicked' 
  }

  # REMOVE ME, we pass subdomain 
  def initialize(subdomain)
    raise 'Subdomain has to be passed to ApiCaller' if subdomain.empty?
    url = "http://subdomain.#{BASE_URL}"

    @faraday = Faraday.new(url: url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def build_uri(req_type, protocol_ver=PROTOCOL_VERSION, zone_id=ZONE_ID)
    "/www/delivery/swfIndex.php?reqType=#{REQUEST_TYPE}&protocolVersion=#{protocol_ver}&zoneId=#{zone_id}"
  end



  def authenticate
  end

  def request(req_type, options)
  end

  def validate_params
  end

  def lower_camelize(lower_case_and_underscored_word, first_letter_in_uppercase = false)
    if first_letter_in_uppercase
      lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
    else
      lower_case_and_underscored_word[0] + camelize(lower_case_and_underscored_word, true)[1..-1]
    end
  end

end
