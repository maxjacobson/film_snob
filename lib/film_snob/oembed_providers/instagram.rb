require "film_snob/oembed_provider"

class FilmSnob
  class Instagram < OembedProvider
    def self.valid_url_patterns
      [
        %r{https?://(?:(?:www).)?instagram.com/p/(\w+)},
        %r{https?://(?:(?:www).)?instagr.am/p/(\w+)}
      ]
    end

    def self.oembed_endpoint
      "https://api.instagram.com/oembed/"
    end

    def clean_url
      @clean_url ||= "http://instagram.com/p/#{id}"
    end
  end
end
