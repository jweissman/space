class Space::EnemyShip < Space::Ship

  def initialize(*args)
    super(*args)
    @x, @y = Space::Universe.random_location
  end

  def handle_input(game, engine)
    player = engine.player
    target_theta = Gosu.angle(@x, @y, player.x, player.y)

    diff = Gosu.angle_diff(target_theta, @theta)
    if diff < 0
      turn(:left, 1.0)
    else
      turn(:right, 1.0) 
    end

    dst = Gosu.distance(player.x, player.y, @x, @y)
    if dst > 250
      accelerate 
    #elsif dst < 150
    #  decelerate
    end

    fire(engine) if rand < 0.05 && dst < 250
  end

  def decelerate(inc=0.9)
    @velocity ||= 0
    @velocity = @velocity - inc
    @velocity = [0, @velocity].max
    self
  end
end
