class Space::EnemyShip < Space::Ship
  def handle_input(game, engine)
    player = engine.player
    target_theta = Gosu.angle(@x, @y, player.x, player.y)
    diff = Gosu.angle_diff(target_theta, @theta)
    if diff < 0
      turn(:left)
    else
      turn(:right)
    end

    dst = Gosu.distance(player.x, player.y, @x, @y)
    if dst > 100
      accelerate 
    elsif dst < 30
      decelerate
    else 
      fire(engine)
    end
  end

    def decelerate(inc=0.9)
      @velocity ||= 0
      @velocity = @velocity - inc
      @velocity = [0, @velocity].max
      self
    end
end
