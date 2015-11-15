require "film_snob/oembed_provider"

class FilmSnob
  class Soundcloud < OembedProvider
    def initialize(url, options = {})
      super(url, options.merge(:format => :json))
    end

    def self.valid_url_patterns
      [
        %r{https?://soundcloud.com/([^/]+/[^?]+)},
        %r{https?://m.soundcloud.com/([^/]+/[^?]+)}
      ]
    end

    def self.oembed_endpoint
      "https://soundcloud.com/oembed"
    end

    def clean_url
      @clean_url ||= "https://soundcloud.com/#{id}"
    end
  end
end
