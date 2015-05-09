module Space
  class ShipView < AnimatedView
    def image_source; 'assets/ship.png' end

    def frame_width; 32 end
    def frame_height; 32 end

    def current_frame
      return super if @model.velocity > 0
      @images.size - 1
    end
  end
end
