module Space
  class Game < Gosu::Window
    def initialize
      super(640, 480, false)
      self.caption = 'SPAAAACE'
      @engine = GameEngine.new(self)
    end

    def update
      @engine.tick(self)
    end

    def draw
      @engine.render
    end

    def button_down(id)
      if id == Gosu::KbEscape
	close
      end
    end
  end
end
