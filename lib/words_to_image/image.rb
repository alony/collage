require 'mini_magick'

module WordsToImage
  class Image
    def initialize(path)
      @path = path
      @square_size = 150 #px
    end

    def squarize!
      img = MiniMagick::Image.new(filename)

      w_original, h_original = [img[:width].to_f, img[:height].to_f]

      # check proportions
      if w_original < h_original
        bigger_side = (h_original * @square_size / w_original).to_i
        remove = "0x#{ ((bigger_side - @square_size)/2.0).to_i }"
      else
        bigger_side = (w_original * @square_size / h_original).to_i
        remove = "#{ ((bigger_side - @square_size)/2.0).to_i }x0"
      end
      op_resize = [bigger_side, bigger_side].join("x")

      img.resize(op_resize)
      img.shave(remove)

      self
    rescue => e
      raise IOError, "failed to modify an image: #{e.message}"
    end

    def download
      open(URI.parse(@path)) { |image|
        File.open(filename, "wb") do |file|
          file.puts image.read
        end
      }

      self
    rescue => e
      raise IOError, "image download error: #{e.message}"
    end

    def filename
      @filename ||= "img_#{Time.now.to_f}#{@path[/\.\w+$/]}"
    end

    def delete!
      File.delete(filename)
    rescue
      puts "! could not delete temporary file: #{filename}"
    end
  end
end