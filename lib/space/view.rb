module Space
  class View
    def initialize(window, model, manager)
      @image = Gosu::Image.new(window, image_source, false)
      @model = model
      @manager = manager
    end

    def render(layer=1)
      @manager.render(@image, @model.x, @model.y, layer, @model.theta)
    end

    def image_source
      # could do something like "#{self.class.name.gsub("View","").downcase}.png"
      raise 'implement in subclass'
    end
  end
end
