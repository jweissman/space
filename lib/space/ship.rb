module Space
  class Ship < Model
    attr_reader :exploding

    def initialize(*args)
      super(*args)

      @exploding = false
      @death_countdown = nil
    end

    # how many ticks between possible weapon firings
    def rate_of_fire; 5 end

    # how fast we slow down
    def rate_of_deceleration; 0.39 end

    def max_flight_speed; 6.5 end

    def accelerate(inc=2.5)
      @velocity ||= 0
      @velocity = @velocity + inc
      @velocity = [max_flight_speed, @velocity].min
      self
    end

    def turn(dir, rate=3.5) 
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
      explode! if engine.bullets.any? { |b| overlap?(b) }

      if @exploding
	@death_countdown = @death_countdown - 1
      else
	move

	@velocity ||= 0
	@velocity -= rate_of_deceleration
	@velocity = 0 if @velocity < 0

	handle_input(game, engine)
      end
    end

    def alive?
      return true unless @death_countdown 
      @death_countdown > 0
    end

    def explode!
      @exploding = true
      @death_countdown = 30
    end

    def fire(engine)
      @last_fired ||= 0
      if engine.tick - @last_fired > rate_of_fire
	bullet_x = x + Gosu::offset_x(@theta, 25)
	bullet_y = y + Gosu::offset_y(@theta, 25)
	bullet = Bullet.new(bullet_x,bullet_y,theta,10+@velocity) #velocity+10)
	engine.bullets << bullet
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
