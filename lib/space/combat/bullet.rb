module Space
  class Bullet < Model
    attr_reader :theta, :velocity, :lifetime

    def depth; 0.0 end

    def move
      @lifetime ||= 50
      @lifetime = @lifetime - 1

      @x += Gosu::offset_x(@theta, @velocity)
      @y += Gosu::offset_y(@theta, @velocity)
    end

    def alive?
      @lifetime <= 100
    end
  end
end
