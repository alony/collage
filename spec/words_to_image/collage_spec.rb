require 'spec_helper'

describe WordsToImage::Collage do
  let(:collage) { WordsToImage::Collage.new('path', 333, 5) }
  let(:image) {double("mini_magick image")}

  before do
    allow_any_instance_of(WordsToImage::Collage).to receive(:get_collage_file)
    allow(MiniMagick::Image).to receive(:new).and_return(image)
  end

  describe "#initialize" do
    it "should fix the path given" do
      expect(collage.instance_variable_get(:"@path")).to eq("./path.jpg")
    end

    context "inexisting path" do
      it "should raise an error" do
        expect {
          WordsToImage::Collage.new('/inexisting/directory/file', 333, 5)
        }.to raise_error(ArgumentError, /Directory unwritable/)
      end
    end
  end

  describe "#+" do
    it "should connect an image to collage" do
      expect(image).to receive(:composite).and_return(double("image", write: {}))

      collage + WordsToImage::Image.new('path')
    end
  end
end