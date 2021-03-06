module Space
  class Viewport
    attr_reader :x, :y

    def initialize(width=640, height=480, xoff=0,yoff=0)
      @width, @height = width, height
      recenter(xoff, yoff)
    end

    def render(image, view=nil, layer=1, angle=0, color=0xFFFFFFFF)
      _x, _y = apply_offset(view)
      image.draw_rot(_x,_y,layer,angle)
      self
    end

    def recenter(_x,_y)
      @x, @y=_x-(@width/2),_y-(@height/2)
      self
    end

    def should_draw?(model, view)
      _x, _y = apply_offset(view)
      visible?(_x,_y,model.width,model.height)
    end

    protected
    def apply_offset(view)
      _x, _y = view.rendering_coordinates(self)
      [_x - @x, _y - @y]
    end

    # in 'local' coords
    def visible?(x,y,w=16,h=16)
      x >= 0 && y >= 0 && @width >= x - w && @height >= y - h
    end
  end
end
