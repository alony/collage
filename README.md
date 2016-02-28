# Words To Image

a Ruby command line application that

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

## Installation
[Please initially install ImageMagick](http://www.imagemagick.org/script/binary-releases.php).

Add this line to your application's Gemfile:

    gem 'words_to_image'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install words_to_image

## Usage Example

    words_to_image --keywords="hamburg weihnachtsmarkt alster moin hafen" --result='result.jpg' --count=5 --max_width=150 --dictionary='spec/fixtures/sample_dict'

All the options are optional, just `words_to_image` would use defaults and random keywords.

