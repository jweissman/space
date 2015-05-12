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
    # def die!
    #   @dying = true 
    # end

    # def collision_with?(other_model)

    # end
  end
end
