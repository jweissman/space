module Space
  class Star < Model
    def move; end

    def depth(max_depth=1.0)
      @depth ||= ((rand * max_depth)+(1-(max_depth/2)))
    end
  end
end
