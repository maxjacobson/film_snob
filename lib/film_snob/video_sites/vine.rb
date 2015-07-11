require "film_snob/video_site"

class FilmSnob
  class Vine < VideoSite
    def self.valid_url_patterns
      [
        %r{https://vine.co/v/(\w+)}
      ]
    end

    def clean_url
      @clean_url ||= "https://vine.co/v/#{id}"
    end

    def self.oembed_endpoint
      "https://vine.co/oembed.json"
    end
  end
end
