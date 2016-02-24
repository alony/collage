class Collage::Collage

  private
  def collection_complete?
    @images.count >= 10 #magick number
  end
end