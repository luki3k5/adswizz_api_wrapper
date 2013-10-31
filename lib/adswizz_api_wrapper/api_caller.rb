module AdswizzApiWrapper
  class ApiCaller
    attr_accessor :faraday, :subdomain, :zone_id

    PROTOCOL_VERSION = 2.0
    BASE_URL         = 'adswizz.com' 
    REQUEST_TYPES    = {
      :m1 => 'AdsSetup',
      :m2 => 'AdsDisplayStarted',
      :m3 => 'AdsSendReport',
      :m4 => 'AdsDisplayEnd',
      :m5 => 'AdsClicked',
      :m6 => 'AdsPreviewStarted',
      :m7 => 'PreviewClicked',
      :m8 => 'LikeClicked',
      :m9 => 'ShareClicked'
    }

    def initialize(options={})
      set_options!(options)

      @faraday = Faraday.new(url: "http://#{subdomain}.#{BASE_URL}") do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end

    def build_uri(req_type=REQUEST_TYPES[:m1], protocol_ver=PROTOCOL_VERSION)
      "/www/delivery/swfIndex.php?reqType=#{req_type}&protocolVersion=#{protocol_ver}&zoneId=#{zone_id}"
    end

    def get_ads_setup
      ads = []
      response = faraday.get(build_uri(REQUEST_TYPES[:m1]))
      document = VAST::Document.parse(response.body)
      document.inline_ads.each { |ad| ads << Ad.new(ad) }
      ads
    end

    def extra_parameters(options={})
      p = "AWPARAMS="
      options.keys.each { |key| p = "#{p}#{key}:#{options[key]};" }
      p
    end

    def set_options!(options)
      validate_options!(options)
      %w(zone_id subdomain).each do |el|
        self.send("#{el}=", options[el.to_sym])
      end
    end

    def validate_options!(options)
      %w(zone_id subdomain).each do |key|
        if !options.has_key?(key.to_sym)
          raise "missing option! #{key} has to be passed to #new"
        end
      end
    end
  end
end
