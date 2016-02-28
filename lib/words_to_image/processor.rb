require 'defaults'

module WordsToImage
  class Processor
    attr_reader :words, :result_path

    def initialize(local_settings={})
      @images_count    = (local_settings[:images_count] || DEFAULT_SETTINGS[:images_count]).to_i
      @dictionary_path = local_settings[:dictionary_path] || DEFAULT_SETTINGS[:dictionary_path]
      @result_path     = local_settings[:result_path] || DEFAULT_SETTINGS[:result_path]
      @max_row_width   = [(local_settings[:max_row_width] || DEFAULT_SETTINGS[:max_row_width]).to_i, 150].max

      @images, @words  = [], []
      @dictionary      = Dictionary.new(@dictionary_path)
    end

    def get_images(keywords=[])
      while !collection_complete?
        keyword = keywords.shift || @dictionary.get_word
        raise ArgumentError, "not enough words to complete a collage" unless keyword

        next unless image = Flickr.fetch( keyword )
        @images << image
        @words << keyword
      end
    end

    def create_collage
      @result = Collage.new(@result_path, @max_row_width, @images.count)

      @images.each do |path|
        image = Image.new(path).download.squarize!
        @result += image
        image.delete!
      end
    end

    private
    def collection_complete?
      @images.count == @images_count
    end
  end
end