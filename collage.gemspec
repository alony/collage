# coding: utf-8
lib = File.expand_path('../lib/collage', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "collage"
  spec.version       = "0.0.1"
  spec.authors       = ["Alona Mekhovova"]
  spec.email         = ["alona.tarasova@gmail.com"]
  spec.summary       = "A collage maker based on flickr search results"
  spec.description   = %q{
    command line application that

    * accepts a list of search keywords as arguments
    * queries the Flickr API for the top-rated image for each keyword
    * downloads the results
    * crops them rectangularly
    * assembles a collage grid from ten images and
    * writes the result to a user-supplied filename

    If given less than ten keywords, or if any keyword fails to
    result in a match, retrieve random words from a dictionary
    source such as `/usr/share/dict/words`. Repeat as necessary
    until you have gathered ten images.
  }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["config", "lib/collage"]

  spec.add_runtime_dependency "flickraw"
  spec.add_runtime_dependency "mini_magick"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
