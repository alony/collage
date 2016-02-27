module WordsToImage
  class Dictionary
    def initialize(path)
      @path = path
    end

    def get_word
      words.delete(words.sample)
    end

    private
    def words
      @words ||= read_content
    end

    def read_content
      contents = File.read(@path)
      contents.split
    rescue => e
      raise IOError, "Dictionary file unreadable: #{e.message}"
    end
  end
end