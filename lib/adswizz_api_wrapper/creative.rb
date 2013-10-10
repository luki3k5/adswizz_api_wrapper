class Creative
  attr_accessor :type, :duration, :video_clicks, :mediafiles, :tracking_urls

  def initialize(creative_details, type)
    @duration        = creative_details.duration
    @mediafiles      = creative_details.mediafiles
    @tracking_events = creative_details.tracking_urls
    @type            = type
  end

  def assign_media_files(media_files)
    mf = []
    media_files.each { |o| mf << MediaFile.create(o) }
    mf
  end
end
