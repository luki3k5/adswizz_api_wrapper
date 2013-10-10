class Creative
  attr_accessor :type, :duration, :video_clicks, :media_files, :tracking_urls

  def initialize(creative_details, type)
    @duration        = creative_details.duration
    @media_files     = assign_media_files(creative_details.mediafiles)
    @tracking_urls   = creative_details.tracking_urls
    @type            = type
  end

  def assign_media_files(media_files)
    mf = []
    media_files.each { |o| mf << MediaFile.new(o) }
    mf
  end
end
