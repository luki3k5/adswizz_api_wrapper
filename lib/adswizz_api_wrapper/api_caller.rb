class ApiCaller
  attr_accessor :faraday, :zone_id

  PROTOCOL_VERSION = 2.0
  BASE_URL         = 'adswizz.com' 
  REQUEST_TYPES    = {
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

  def initialize(options)
    validate_options!(options)

    zone_id   = options[:zone_id] 
    subdomain = options[:subdomain]

    url = "http://#{subdomain}.#{BASE_URL}"

    @faraday = Faraday.new(url: url) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def build_uri(req_type=REQUEST_TYPES[:m1], protocol_ver=PROTOCOL_VERSION)
    "/www/delivery/swfIndex.php?reqType=#{req_type}&protocolVersion=#{protocol_ver}&zoneId=#{zone_id}"
  end

  def get_ads_setup
    response = faraday.get(build_uri(REQUEST_TYPES[:m1]))
    document = VAST::Document.parse(response.body)
    puts document.inline_ads.each { |ad| Ad.new(ad) }.class
  end

  def validate_options!(options)
    %w(zone_id subdomain).each do |key|
      if !options.has_key?(key.to_sym)
        raise "missing option! #{key} has to be passed to #new"
      end
    end
  end

  #def lower_camelize(lower_case_and_underscored_word, first_letter_in_uppercase = false)
    #if first_letter_in_uppercase
      #lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
    #else
      #lower_case_and_underscored_word[0] + camelize(lower_case_and_underscored_word, true)[1..-1]
    #end
  #end

end
