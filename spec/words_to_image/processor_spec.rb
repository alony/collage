require 'spec_helper'

describe WordsToImage::Processor do
  let(:processor) { WordsToImage::Processor.new }

  describe "#initialize" do
    it "should set all default configs" do
      WordsToImage::DEFAULT_SETTINGS.each_pair do |setting, value|
        expect(processor.instance_variable_get(:"@#{setting}")).to eq value
      end
    end

    it "should setup the user input vars with higher prio" do
      local_settings = {
        images_count:     3,
        dictionary_path:  'other path',
        result_path:      'my secret place'
      }

      processor1 = WordsToImage::Processor.new(local_settings)
      local_settings.each_pair do |setting, value|
        expect(processor1.instance_variable_get(:"@#{setting}")).to eq value
      end
    end
  end

  describe "#get_images" do
    let(:processor) { WordsToImage::Processor.new(images_count: 5) }

    before do
      allow(WordsToImage::Flickr).to receive(:fetch).and_return("http://image_url")
    end

    it "should fetch enough images using keywords" do
      processor.get_images(["word1", "word2", "word3", "word4", "word5"])

      expect(processor.instance_variable_get(:"@images").count).to eq 5
    end

    it "should use the dictionary it additional words needed" do
      expect_any_instance_of(WordsToImage::Dictionary).to receive(:get_word).exactly(3).times.and_return("random word")

      processor.get_images(["word1", "word2"])
    end

    context "not enough words available" do
      before do
        allow_any_instance_of(WordsToImage::Dictionary).to receive(:words).and_return([])
      end

      it "should raise an error" do
        expect{processor.get_images}.to raise_error(ArgumentError)
      end
    end
  end
end