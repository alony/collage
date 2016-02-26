module Collage
  class Collage

    private
    def collection_complete?
      @images.count >= 10 #magic number
    end
  end
end