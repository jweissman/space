module Space
  class AnimatedView < View
    def initialize(window, model, manager)
      @images = Gosu::Image.load_tiles(window, image_source, frame_width, frame_height, false)
      @model   = model
      @manager = manager
    end

    def render(layer=1,frame=current_frame)
      @manager.render(@images[frame], @model.x, @model.y, layer, @model.theta)
    end

    def current_frame
      Gosu::milliseconds / 100 % @images.size
    end

    def frame_width; raise 'implement in subclass' end
    def frame_height; raise 'implement in subclass' end
  end
end