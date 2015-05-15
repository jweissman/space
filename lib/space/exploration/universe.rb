module Space
  module Universe
    def self.random_location
      [ -(self.width / 2) + (rand * self.width),
        -(self.height / 2) + (rand * self.height)]
    end

    def self.star_population
      3_000
    end

    def self.width
      10_000
    end

    def self.height
      10_000
    end
  end
end
