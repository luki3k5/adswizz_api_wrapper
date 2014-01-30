module AdswizzApiWrapper
  class ApiCaller
    attr_accessor :faraday, :subdomain, :zone_id, :extra_params, :client_locale_and_lang

    DEFAULT_LOC_AND_LANG = 'de-de'

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
      @client_locale_and_lang ||= 'de-de'
      @faraday = Faraday.new(:url => "http://#{subdomain}.#{BASE_URL}") do |f|
        f.request  :url_encoded             # form-encode POST params
#        f.response :logger                  # log requests to STDOUT
        f.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def build_uri(req_type=REQUEST_TYPES[:m1], protocol_ver=PROTOCOL_VERSION)
      url = "/www/delivery/swfIndex.php?reqType=#{req_type}&protocolVersion=#{protocol_ver}&zoneId=#{zone_id}"
      url = "#{url}&#{extra_parameters(extra_params)}" if !@extra_params.nil?
      url
    end

    def adex_get_ads_setup(uri=nil)
      ads      = []
      uri      = build_uri(REQUEST_TYPES[:m1]) if uri == nil
      response = @faraday.get do |req|
        req.url uri
        req.headers = { "Accept-Language" => client_locale_and_lang }
      end
      document = VAST::Document.parse(response.body)

      # if we are still receiving just references - another call (VASTAdTagURI)
      if document.wrapper_ads.first
        return adex_get_ads_setup(document.wrapper_ads.first.ad_tag_url)
      end

      # if this time we got ads we will parse them normally
      if document.inline_ads
        document.inline_ads.each { |ad| ads << Ad.new(ad) }
        return ads
      end
    end

    def get_ads_setup
      ads = []
      response = @faraday.get do |req|
        req.url build_uri(REQUEST_TYPES[:m1])
        req.headers = { "Accept-Language" => client_locale_and_lang }
      end
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
      %w(zone_id subdomain client_locale_and_lang).each do |el|
        self.send("#{el}=", options[el.to_sym])
      end
      @extra_params = options[:extra_options]
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
