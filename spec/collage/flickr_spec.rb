require 'spec_helper'

describe Collage::Flickr do
  describe ".fetch" do
    before do
      allow(FlickRaw::Flickr).to receive(:new).and_return(OpenStruct.new(photos: {}))
    end

    context "image found" do
      before do
        photo_info = {id: 123, server: 456, title: "Pure beauty"}

        allow(flickr.photos).to receive("search").and_return([photo_info])
        allow(FlickRaw).to receive("url_q").with(OpenStruct).and_return("http://image_url")
      end

      it "should fetch an image using flickr API" do
        expect(Collage::Flickr.fetch("weihnachten")).to eq "http://image_url"
      end
    end

    context "nothing found" do
      before do
        allow(flickr.photos).to receive("search").and_return([])
      end

      it "should return nil if nothing fetched" do
        expect(Collage::Flickr.fetch("weihnachten")).to be_nil
      end
    end
  end
end