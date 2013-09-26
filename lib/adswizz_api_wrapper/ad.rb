class Ad
  attr_accessor :ad_system, :ad_title, :description, :impression, :linear_creatives

  def initialize(ad_details)
    raise "Expected VAST::InlineAd class!" if !ad_details.is_a?(VAST::InlineAd)

    @ad_system   = ad_details.ad_system
    @ad_title    = ad_details.ad_title
    @linear_creatives = assign_creatives(ad_details.linear_creatives)
  end

  def assign_creatives(linear_creatives)
    lc = []
    linear_creatives.each { |c| lc << Creative.new(c, :linear) }
    lc
  end

  def to_s
    "Ad: #{ad_system} #{ad_title}"
  end
end
