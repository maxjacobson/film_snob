require "film_snob/video_site"

class FilmSnob
  class Hulu < VideoSite
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
