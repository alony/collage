require 'spec_helper'

describe WordsToImage::Dictionary do
  SAMPLE_PATH = 'spec/fixtures/sample_dict'

  describe "#get_word" do
    let(:dictionary) { WordsToImage::Dictionary.new(SAMPLE_PATH) }

    it "should return one word from the set" do
      words = File.read(SAMPLE_PATH).split

      words.count.times do
        expect(words).to include(dictionary.get_word)
      end
    end

    it "should return words in random order" do
      dict2 = WordsToImage::Dictionary.new(SAMPLE_PATH)

      words = (1..5).map { dictionary.get_word }
      words2 = (1..5).map { dict2.get_word }

      expect(words).not_to eq words2
    end

    context "no words left" do
      before do
        allow(dictionary).to receive(:read_content).and_return([])
      end

      it "should return nil" do
        expect(dictionary.get_word).to be_nil
      end
    end

    context "file unreadable" do
      let(:inexisting_dict) { WordsToImage::Dictionary.new('/inexisting/path') }

      it "should raise an exception with verbose description" do
        expect{inexisting_dict.get_word}.to raise_error(IOError)
      end
    end
  end
end