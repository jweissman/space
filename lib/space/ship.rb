module Space
  class Ship < Model
    # how many ticks between possible weapon firings
    def rate_of_fire; 5 end

    # how fast we slow down
    def rate_of_deceleration; 0.09 end

    def max_flight_speed; 4.5 end

    def accelerate(inc=1.5)
      @velocity ||= 0
      @velocity = @velocity + inc
      @velocity = [max_flight_speed, @velocity].min
      self
    end

    def turn(dir, rate=2.4) 
      if dir == :left
	@theta += rate
      elsif dir == :right
	@theta -= rate
      else
	raise "Unknown direction for turning '#{dir}'"
      end
      self
    end

    # on tick
    def update(game,engine)
      move

      @velocity ||= 0
      @velocity -= rate_of_deceleration
      @velocity = 0 if @velocity < 0

      handle_input(game, engine)
    end

    def fire(engine)
      @last_fired ||= 0
      if engine.tick - @last_fired > rate_of_fire
	bullet = Bullet.new(x,y,theta,velocity+10)
	engine.add_model(bullet)
	@last_fired = engine.tick
      end
    end

    def handle_input(game, engine)
      if game.button_down?(Gosu::KbLeft)
	turn(:left)
      elsif game.button_down?(Gosu::KbRight)
	turn(:right)
      end

      if game.button_down?(Gosu::KbUp)
	accelerate
      end

      if game.button_down?(Gosu::KbSpace)
	fire(engine)
      end
    end
  end
end
