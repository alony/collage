require 'defaults'

module Collage
  class Collage
    def initialize(local_settings={})
      @images_count    = local_settings[:images_count] || DEFAULT_SETTINGS[:images_count]
      @dictionary_path = local_settings[:dictionary_path] || DEFAULT_SETTINGS[:dictionary_path]
      @result_path     = local_settings[:result_path] || DEFAULT_SETTINGS[:result_path]
      @images          = Array.new
      @dictionary      = Dictionary.new(@dictionary_path)
    end

    def get_images(keywords=[])
      while !collection_complete?
        keyword = keywords.shift || @dictionary.get_word
        raise ArgumentError, "not enough words to complete a collage" unless keyword

        next unless image = Flickr.fetch( keyword )
        @images << image
      end
    end

    def create
      @images.map do |path|
        Image.new(path).download.squarize!
      end.reduce(@result, :+)
    end

    private
    def collection_complete?
      @images.count == @images_count
    end
  end
end