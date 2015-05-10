module Space
  class Star < Model
    def move; end

    def depth(max_depth=0.4)
      @depth ||= ((rand * max_depth)+0.8)
    end
  end
end
