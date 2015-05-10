module Space
  class Game < Gosu::Window
    include Gosu

    attr_reader :engine

    def initialize
      super(1080, 720, true)
      self.caption = 'SPAAAACE'
      @engine = GameEngine.new(self)
    end

    def update
      @engine.step
    end

    def draw
      @engine.render
    end

    def button_down(id)
      if id == KbEscape
	close
      end
    end
  end
end
