class Creative
  attr_accessor :type, :duration, :video_clicks, :media_files, :tracking_events

  def initialize(creative_details, type)
    @duration        = creative_details.duration
    @media_files     = creative_details.media_files
    @tracking_events = creative_details.tracking_events
    @type            = type
  end

  def assign_media_files(media_files)
    mf = []
    media_files.each { |o| mf << MediaFile.create(o) }
    mf
  end
end
