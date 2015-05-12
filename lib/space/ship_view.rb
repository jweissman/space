module Space
  class ShipView < AnimatedView
    def image_source; 'assets/ship.png' end

    def frame_width; 32 end
    def frame_height; 32 end

    def current_frame
      return super if @model.velocity > 1.0
      # return @images.size-1 if @model.dying?
      0 #@images.size - 1
    end

    # exclude exploding frame...
    def active_frames
      1..(@images.size-2)
    end
  end
end
