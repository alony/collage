Dir.glob('lib/**/*.rb') {|file| require File.basename(file)}

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end