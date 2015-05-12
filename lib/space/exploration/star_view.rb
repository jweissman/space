module Space
  class StarView < AnimatedView
    def image_source; "assets/stars.png" end

    def frame_width; 16 end
    def frame_height; 16 end

    def current_frame
      @selected_frame ||= (rand * @images.size).to_i 
    end

    def rendering_coordinates(viewport=nil)
      if viewport
	[(@model.x) - (viewport.x * @model.depth), 
	 (@model.y) - (viewport.y * @model.depth)]
      else
	[@model.x, @model.y]
      end
    end
  end
end
