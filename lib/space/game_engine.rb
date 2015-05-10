module Space

  class GameEngine
    attr_reader :tick, :models
    attr_reader :player, :view_manager
    
    def initialize(game)
      @game = game
      @models = []

      @view_manager = Viewport.new(@game.width, @game.height)

      @player = Ship.new
      add_model @player

      @enemy_ship = EnemyShip.new
      add_model @enemy_ship

      @starfield = Array.new(Universe.star_population) do 
	x, y = Universe.random_location
	print '.'
	Star.new(x,y)
      end

      @starfield.each(&method(:add_model))
      @tick = 0
    end

    def add_model(model)
      @models << model
      self
    end

    def step
      @tick = @tick + 1
      @models.select!(&:alive?)
      @models.each(&method(:update_model))
    end

    def render
      x,y = @player.x, @player.y
      @view_manager.recenter(x,y)
      visible_models.each(&method(:render_model))
      self
    end

    def visible_models
      @models.select(&method(:visible?))
    end

    protected
    def visible?(model)
      @view_manager.should_draw?(model, view_for_model(model))
    end

    def update_model(model)
      model.update(@game, self)
    end

    def render_model(model)
      view_for_model(model).render
      self
    end

    def view_for_model(model)
      @views ||= {}
      @views[model.class] ||= {}
      @views[model.class][model.id] ||= eval("#{model.class.name}View").new(@game, model, @view_manager)
    end
  end
end
