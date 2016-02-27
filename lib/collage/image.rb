module Collage
  class Image
    def initialize(path)
      @path = path
    end

    def squarize!
      self
    end

    def +( image )
      self
    end

    private
    def download
      self
    end
  end
end