require "film_snob/oembed_provider"

class FilmSnob
  class Hulu < OembedProvider
    def self.valid_url_patterns
      [
        %r{https?://(?:(?:www).)?hulu.com/watch/(\d+)}
      ]
    end

    def self.oembed_endpoint
      "http://www.hulu.com/api/oembed.json"
    end

    def clean_url
      @clean_url ||= "http://www.hulu.com/watch/#{id}"
    end
  end
end

