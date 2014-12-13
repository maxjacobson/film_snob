require "film_snob/oembed_provider"

class FilmSnob
  class Vimeo < OembedProvider
    def self.valid_url_patterns
      [
        %r{https?://vimeo.com/(\d{1,})},
        %r{https?://vimeo.com/m/(\d{1,})},
        %r{https?://vimeo.com/couchmode/\w+/[\w:]+/(\d{1,})},
        %r{https?://vimeo.com/channels/\w+/(\d{1,})}
      ]
    end

    def clean_url
      @clean_url ||= "https://vimeo.com/#{id}"
    end

    def self.oembed_endpoint
      "http://vimeo.com/api/oembed.json"
    end
  end
end

