module Space
  class Model
    attr_reader :id
    attr_reader :x, :y, :theta, :velocity
    attr_reader :width, :height

    def initialize(x=0,y=0,angle=0,vel=0,w=16,h=16)
      @id = SecureRandom.uuid
      @x, @y = x, y
      @theta = angle
      @velocity = vel
      @width, @height = w, h
    end

    def update(game, engine)
      move
    end

    def move
      @x += Gosu::offset_x(@theta, @velocity)
      @y += Gosu::offset_y(@theta, @velocity)
    end

    def location; [ @x, @y ] end

    def alive?; true end

    def overlap?(other_model)
      x_overlap = (self.x..self.x + self.width).cover?(other_model.x) || 
	(other_model.x..(other_model.x + other_model.width)).cover?(self.x)

      y_overlap = (self.y..self.y + self.height).cover?(other_model.y) || 
	(other_model.y..(other_model.y + other_model.height)).cover?(self.y)

      return x_overlap && y_overlap
    end
  end
end
