module Space
  class Bullet < Model
    attr_reader :theta, :velocity #, :lifetime

    def move
      @velocity ||= 10.0
      #@lifetime ||= 50

      # @lifetime = @lifetime - 1

      @x += Gosu::offset_x(@theta, @velocity)
      @y += Gosu::offset_y(@theta, @velocity)
    end
  end
end
