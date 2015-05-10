module Space

  class View
    def initialize(window, model, manager)
      @image = ImageRepository.find_or_load(model.class.name.to_sym, window, image_source) # Gosu::Image.new(window, image_source, false)
      @model = model
      @manager = manager
    end

    def render(layer=1)
      _x, _y = rendering_coordinates
      @manager.render(@image, self, layer, @model.theta)
    end

    def image_source
      # could do something like "#{self.class.name.gsub("View","").downcase}.png"
      raise 'implement in subclass'
    end

    def rendering_coordinates(viewport=nil)
      [@model.x, @model.y]
    end
  end
end
