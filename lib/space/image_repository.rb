module Space
  module ImageRepository
    def self.images
      @images ||= {}
    end

    def self.find_or_load(img, window, src)
      return self.images[img] if self.images.has_key?(img) 
      self.images[img] = Gosu::Image.new(window, src, false)
    end

    def self.find_or_load_tiles(img, window, src, frame_width, frame_height)
      return self.images[img] if self.images.has_key?(img) 
      self.images[img] = Gosu::Image.load_tiles(window, src, frame_width, frame_height, false)
    end

  end
end
