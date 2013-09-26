class Ad
  attr_accessor :ad_system, :ad_title, :description, :impression, :creatives

  def initialize(ad_details)
    raise "Expected VAST::InlineAd class!" if !ad_details.is_a?(VAST::InlineAd)

    @ad_system   = ad_details.ad_system
    @ad_title    = ad_details.ad_title
    @description = ad_details.description
    @creatives   = ad_details.creatives.each { |c| Creative.new(ad_details.creatives) }
  end

  def to_s
    "Ad: #{ad_system} #{ad_title}"
  end
end
