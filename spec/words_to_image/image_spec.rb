require 'spec_helper'

describe WordsToImage::Image do
  let(:image) { WordsToImage::Image.new('http://image.jpg') }
  let(:image_file) { double("image file", shave: nil, resize: nil) }
  before do
    allow(MiniMagick::Image).to receive(:new).and_return(image_file)
  end

  describe "#squarize!" do
    context "initially square image" do
      before do
        allow(image_file).to receive(:[]).with(:width).and_return(300)
        allow(image_file).to receive(:[]).with(:height).and_return(300)
      end

      it "should resize the image" do
        expect(image_file).to receive(:resize).with("150x150")

        image.squarize!
      end

      it "should NOT crop the image" do
        expect(image_file).to receive(:shave).with("0x0")

        image.squarize!
      end
    end

    context "image has landscape layout" do
      before do
        allow(image_file).to receive(:[]).with(:width).and_return(400)
        allow(image_file).to receive(:[]).with(:height).and_return(300)
      end

      it "should resize the image by longer part" do
        expect(image_file).to receive(:resize).with("200x200")

        image.squarize!
      end

      it "should crop the image horizontally" do
        expect(image_file).to receive(:shave).with("25x0")

        image.squarize!
      end
    end

    context "image has portrait layout" do
      before do
        allow(image_file).to receive(:[]).with(:width).and_return(200)
        allow(image_file).to receive(:[]).with(:height).and_return(400)
      end

      it "should resize the image by longer part" do
        expect(image_file).to receive(:resize).with("300x300")

        image.squarize!
      end

      it "should crop the image vertically" do
        expect(image_file).to receive(:shave).with("0x75")

        image.squarize!
      end
    end

  end
end