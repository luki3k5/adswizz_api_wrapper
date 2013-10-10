module AdswizzApiWrapper
  class MediaFile
    attr_accessor :url, :id, :type, :delivery, :bitrate, :width, :height

    def initialize(media_file_details) # FIXME 
      %w(url id type delivery bitrate width height).each do |v|
        self.instance_variable_set("@#{v}", media_file_details.send(v.to_sym))
      end
    end
  end
end
