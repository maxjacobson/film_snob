require "film_snob/oembed_provider"

class FilmSnob
  class Rdio < OembedProvider
    def self.valid_url_patterns
      [
        %r{http?://www.rdio.com/artist/(?:[\w\d\-_]+/album/)}
      ]
    end

    # in this case, we're trusting Rdio to clean up the URL
    def clean_url
      @clean_url = url
    end

    def self.oembed_endpoint
      "http://www.rdio.com/api/oembed/"
    end
  end
end
