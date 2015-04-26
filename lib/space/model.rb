module Space
  class Model
    attr_reader :x, :y, :theta

    def initialize(x=0,y=0,angle=0)
      @x, @y = x, y
      @theta = angle
    end
  end
end
