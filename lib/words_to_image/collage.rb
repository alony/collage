require 'defaults'

module WordsToImage
  class Collage
    def initialize(path, max_row_width, images_count)
      @path             = valid_path(path)
      @img_per_row      = [(max_row_width / 150).to_i, images_count].min
      @rows_count       = (images_count / @img_per_row.to_f).ceil

      @images_connected = 0
      get_collage_file
    end

    def +( image )
      img = MiniMagick::Image.new(@path)
      second_image = MiniMagick::Image.new(image.filename)

      img = img.composite(second_image) do |i|
        i.compose "Over"
        i.geometry "+#{horizontal_offset}+#{vertical_offset}"
      end
      img.write(@path)

      @images_connected += 1
      self
    end

    private
    def get_collage_file
      `convert -size #{@img_per_row * 150}x#{@rows_count * 150} canvas:white #{@path}`
    end

    def horizontal_offset
      (@images_connected % @img_per_row) * 150
    end

    def vertical_offset
      (@images_connected / @img_per_row) * 150
    end

    def valid_path(path)
      dir, base = File.split(path)

      base += ".jpg" unless base[/\.\w+$/]

      raise "Directory unwritable" unless File.writable?(dir)

      "#{dir}/#{base}"
    rescue => e
      raise ArgumentError, "invalid result file path: #{e.message}"
    end
  end
end