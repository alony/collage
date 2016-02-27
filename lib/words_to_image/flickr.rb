require "flickraw"
require "flickr_init"

module WordsToImage
  class Flickr
    def self.fetch(keyword)
      photo = flickr.photos.search(text: keyword, media: :photos, per_page: 1, sort: "interestingness-desc").first
      return if photo.nil?

      FlickRaw.url_q OpenStruct.new(photo.to_hash)
    rescue => e
      raise "problem connecting to flickr API"
    end
  end
end