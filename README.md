# film_snob

[![Build Status](https://travis-ci.org/maxjacobson/film_snob.svg?branch=master)](https://travis-ci.org/maxjacobson/film_snob)
[![Gem Version](https://badge.fury.io/rb/film_snob.svg)](http://badge.fury.io/rb/film_snob)
[![Code Climate](https://codeclimate.com/github/maxjacobson/film_snob.png)](https://codeclimate.com/github/maxjacobson/film_snob)
[![Test Coverage](https://codeclimate.com/github/maxjacobson/film_snob/badges/coverage.svg)](https://codeclimate.com/github/maxjacobson/film_snob)

Lookup things like titles and HTML embed codes for web media like videos,
pictures, and songs.

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

film_snob uses the oembed protocol to get html for embed codes. These options
assume some knowledge of the endpoint's API. The above vimeo example works
because they [have an extensively documented API][vimeo] which allows tons of
configuration. The other two don't seem to have any documentation or
configuration at all.

[vimeo]: http://developer.vimeo.com/apis/oembed

### Performance

The interface described above is nice for unknown URLs because you can use
film_snob to check if a URL should be embeddable, and then if it should be, you
can ask it for the HTML.

If you know for sure that a URL ought to be a YouTube video, it will be faster
to use an interface like this one:

```ruby
film = FilmSnob::YouTube.new("https://www.youtube.com/watch?v=st21dIMaGMs")
film.title #=> "Key & Peele - Continental Breakfast"
film.html #=> "<iframe width=\"480\" height=\"270\" src=\"https://www.youtube.com/embed/st21dIMaGMs?feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>"
```

## Supported Sites

* YouTube
* Vimeo
* Hulu
* Funny or Die
* Coub
* Instagram
* Dailymotion
* Vine
* Rutube
* Soundcloud
* Rdio

The same methods work with all of these providers.

## Testing

Run `bundle exec rake spec` to run all of the tests.

If you like TDD, you might want to run `bundle exec guard` instead, which will
listen for your changes and auto-run your tests when you save them or the
related files.

## Code Style

Run `bundle exec rake style` to confirm the codebase is looking stylish.

## Continous Integration

Run `bundle exec rake ci` to run both the tests and the style checks, which
will be run on Travis; both should pass to have a green build.

## Questions?

[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/maxjacobson/film_snob?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Ping me in [the Gitter chat room](https://gitter.im/maxjacobson/film_snob) or
[create a GitHub issue](https://github.com/maxjacobson/film_snob/issues/new)

## Contributing

Bug reports and pull requests are welcome on GitHub at
<https://github.com/maxjacobson/smashcut>. This project is intended to be a
safe, welcoming space for collaboration, and contributors are expected to
adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.

## Releasing a new version

* change the version in `version.rb`.
* describe what changed in `CHANGELOG.md`
* commit the change
* run `bundle exec rake release` to create a git tag, push the code to github,
  and push the release to rubygems
* describe the release on [the releases page][]

[the releases page]: https://github.com/maxjacobson/film_snob/releases
