module Space
  class Ship < Model
    attr_reader :theta, :velocity

    def move(decel=0.03)
      @velocity ||= 0
      @velocity -= decel
      @velocity = 0 if @velocity < 0

      @x += Gosu::offset_x(@theta, @velocity)
      @y += Gosu::offset_y(@theta, @velocity)
    end

    def accelerate(inc=0.3)
      @velocity ||= 0
      @velocity = @velocity + inc
      self
    end

    def turn(dir, rate=6) 
      if dir == :left
	@theta += rate
      elsif dir == :right
	@theta -= rate
      else
	raise "Unknown direction for turning '#{dir}'"
      end
      self
    end
  end
end
