module Space
  class GameEngine
    attr_reader :player_view, :view_manager

    def initialize(game)
      @game = game

      @view_manager = Viewport.new(@game.width, @game.height)

      @player = Ship.new
      @player_view = ShipView.new(game, @player, @view_manager)

      @bullets = []
      @bullet_views = []

      @starfield = Array.new(100) do 
	x, y = Universe.random_location
	Star.new(x,y)
      end

      @starfield_views = @starfield.map do |star|
	StarView.new(game, star, @view_manager)
      end

      @t = 0
    end

    def tick(game)
      @t = @t + 1
      puts "--- engine tick!"
      if game.button_down?(Gosu::KbLeft)
	@player.turn(:left)
      elsif game.button_down?(Gosu::KbRight)
	@player.turn(:right)
      elsif game.button_down?(Gosu::KbUp)
	@player.accelerate
      elsif game.button_down?(Gosu::KbSpace)
	@last_fired ||= 0
	if @t - @last_fired > @player.rate_of_fire
	  bullet = Bullet.new(@player.x,@player.y,@player.theta)
	  @bullets << bullet
	  @bullet_views << BulletView.new(game, bullet, @view_manager)
	  @last_fired = @t
	end
      end

      @player.move
      @bullets.each(&:move)
    end

    def render
      x,y = @player.x, @player.y
      @view_manager.recenter(x,y)

      @player_view.render
      @starfield_views.each(&:render)
      @bullet_views.each(&:render)
    end
  end

end
