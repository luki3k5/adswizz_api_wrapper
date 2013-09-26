class Creative
  attr_accessor :type, :duration, :video_clicks, :media_files, :tracking_events

  def initialize(creative_details, type)
    @type = type
  end
end
