module Space
  class Viewport
    attr_reader :x, :y

    def initialize(width=640, height=480, xoff=0,yoff=0)
      # puts "--- New viewport created with dimensions #{width}x#{height}"
      @width, @height = width, height
      recenter(xoff, yoff)
    end

    def render(image, _x, _y, layer=1, angle=0, color=0xFFFFFFFF)
      _x, _y = apply_offset(_x, _y)
      cx, cy = 0.5, 0.5
      fx, fy = 1.0, 1.0
      image.draw_rot(_x,_y,layer,angle) #,cx,cy,fx,fy, color)
      self
    end

    def recenter(_x,_y)
      @x, @y=_x-(@width/2),_y-(@height/2)
      # puts "--- Centering at #{@x}, #{@y} (based on dimensions #{@width}x#{@height})"
      self
    end

    def should_draw?(model) #_x,_y,w,h)
      _x, _y = apply_offset(model.x, model.y)
      visible?(_x,_y,model.width,model.height)
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
