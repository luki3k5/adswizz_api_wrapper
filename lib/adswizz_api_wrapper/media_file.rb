class MediaFile
  attr_accessor :url, :id, :type, :delivery, :bitrate, :width, :height

  def initialize(media_file_details)
    @url      = media_file_details.url
    @id       = media_file_details.id
    @type     = media_file_details.type
    @delivery = media_file_details.delivery
    @bitrate  = media_file_details.bitrate
    @width    = media_file_details.width
    @height   = media_file_details.height
  end
end
