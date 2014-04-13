# film_snob

[![Build Status](https://travis-ci.org/maxjacobson/film_snob.svg?branch=master)](https://travis-ci.org/maxjacobson/film_snob)
[![Gem Version](https://badge.fury.io/rb/film_snob.svg)](http://badge.fury.io/rb/film_snob)

Helps parse URLs of web videos.

## Installation

Add this line to your application's Gemfile:

    gem 'film_snob'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install film_snob

## Usage

```ruby
snob = FilmSnob.new("https://www.youtube.com/watch?v=GwT3zH16w3s")
snob.watchable? #=> true
snob.site       #=> :youtube
snob.id         #=> "GwT3zH16w3s"
snob.title      #=> "What Are You, The Coolest? With Robert Rodriguez"
snob.html       #=> "<iframe width=\"480\" height=\"270\" src=\"http://www.youtube.com/embed/GwT3zH16w3s?feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>"
```

## Supported video providers

* YouTube
* Vimeo
* Hulu

The same methods work with all of these providers.

## Testing

Run `rake` to run all of the rspecs.

## Contributing

1. Fork it ( https://github.com/maxjacobson/film_snob/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
