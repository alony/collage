Dir.glob('lib/**/*.rb') {|file| require File.basename(file)}

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
  config.before { allow(FlickRaw::Flickr).to receive(:new).and_return(OpenStruct.new(photos: {})) }
end