# film_snob

[![Build Status](https://travis-ci.org/maxjacobson/film_snob.svg?branch=master)](https://travis-ci.org/maxjacobson/film_snob)
[![Gem Version](https://badge.fury.io/rb/film_snob.svg)](http://badge.fury.io/rb/film_snob)
[![Code Climate](https://codeclimate.com/github/maxjacobson/film_snob.png)](https://codeclimate.com/github/maxjacobson/film_snob)
[![Test Coverage](https://codeclimate.com/github/maxjacobson/film_snob/badges/coverage.svg)](https://codeclimate.com/github/maxjacobson/film_snob)

Helps parse URLs of web videos.

## Installation

Add this line to your application's Gemfile:

    gem "film_snob"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install film_snob

## Usage

```ruby
film = FilmSnob.new("https://www.youtube.com/watch?v=GwT3zH16w3s")
film.embeddable? #=> true
film.site       #=> :youtube
film.id         #=> "GwT3zH16w3s"
film.title      #=> "What Are You, The Coolest? With Robert Rodriguez"
film.html       #=> "<iframe width=\"480\" height=\"270\" src=\"http://www.youtube.com/embed/GwT3zH16w3s?feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>"
```

Can also pass some configuration options like this:

```ruby
film = FilmSnob.new("http://vimeo.com/64683454", width: 720)
film.title #=> "Garann Means - Bacon is bad for you"
film.html  #=> "<iframe src=\"//player.vimeo.com/video/64683454\" width=\"720\" height=\"405\" frameborder=\"0\" title=\"Garann Means - Bacon is bad for you\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
```

film_snob uses the oembed protocol to get html for embed codes. These options assume some knowledge of the endpoint's API. The above vimeo example works because they [have an extensively documented API](http://developer.vimeo.com/apis/oembed) which allows tons of configuration. The other two don't seem to have any documentation or configuration at all.

## Supported video providers

* YouTube
* Vimeo
* Hulu
* Funny or Die
* Coub
* Instagram
* Dailymotion
* Vine

The same methods work with all of these providers.

## Testing

Run `rake` to run all of the rspecs.

## Code Style

Run `rubocop` and try to keep the cops happy.

## Questions?

[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/maxjacobson/film_snob?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Ping me in [the Gitter chat room](https://gitter.im/maxjacobson/film_snob) or [create a GitHub issue](https://github.com/maxjacobson/film_snob/issues/new)

## Contributing

1. Fork it ( https://github.com/maxjacobson/film_snob/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Add some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

