require 'spec_helper'

describe WordsToImage::Image do
  let(:image) { WordsToImage::Image.new('http://image.jpg') }

  describe "#download" do
    it "should download an image from flickr" do

    end

    context "download impossible" do
      it "should raise an error" do
      end
    end
  end

  describe "#squarize!" do
    it "should crop the image" do
    end

    it "should save a result in the same file" do
    end
  end
end