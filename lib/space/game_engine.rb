module Space
  class GameEngine
    attr_reader :player_view, :view_manager

    def initialize(game)
      @game = game

      @view_manager = Viewport.new(@game.width, @game.height)

      @player = Ship.new
      @player_view = ShipView.new(game, @player, @view_manager)

      @starfield = Array.new(100) do 
	x, y = Universe.random_location
	Star.new(x,y)
      end

      @starfield_views = @starfield.map do |star|
	StarView.new(game, star, @view_manager)
      end
    end

    def tick(game)
      puts "--- engine tick!"
      if game.button_down?(Gosu::KbLeft)
	@player.turn(:left)
      elsif game.button_down?(Gosu::KbRight)
	@player.turn(:right)
      elsif game.button_down?(Gosu::KbUp)
	@player.accelerate
      end

      @player.move
    end

    def render
      x,y = @player.x, @player.y
      @view_manager.recenter(x,y)

      @player_view.render
      @starfield_views.each(&:render)
    end
  end

end
