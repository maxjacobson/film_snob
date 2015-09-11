require "film_snob/video_site"

class FilmSnob
  class Rutube < VideoSite
    def initialize(url, options = {})
      super(url, options.merge(format: :json))
    end

    def self.valid_url_patterns
      [
        %r{http://rutube.ru/video/(\w*)/}
      ]
    end

    def self.oembed_endpoint
      "http://rutube.ru/api/oembed/"
    end

    def clean_url
      @clean_url ||= "http://rutube.ru/video/#{id}/"
    end
  end
end
