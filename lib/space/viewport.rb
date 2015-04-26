module Space
  class Viewport
    attr_reader :x, :y

    def initialize(width=640, height=480, xoff=0,yoff=0)
      @width, @height = width, height
      recenter(xoff, yoff)
    end

    def render(image, _x, _y, layer=1, angle=0)
      x, y = apply_offset(_x, _y)
      return unless visible?(x,y)
      image.draw_rot(x,y,layer,angle)
      self
    end

    def recenter(_x,_y)
      @x, @y=_x-(@width/2),_y-(@height/2)
      self
    end

    protected
    # from 'global' coords
    def apply_offset(_x,_y)
      [_x - @x, _y - @y]
    end

    # in 'local' coords
    def visible?(x,y,w=16,h=16)
      x >= 0 && y >= 0 && @width >= x - w && @height >= y - h
    end
  end
end
