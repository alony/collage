module Collage
  class Flickr
    def fetch(keyword)
      #save this console experiment here
      photo = flickr.photos.search text: keyword, media: :photos, per_page: 1, sort: "interestingness-desc"
    end
  end
end