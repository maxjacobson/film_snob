require "film_snob/video_site"

class FilmSnob
  class Rutube < VideoSite

    def self.valid_url_patterns
      [
        %r{http://rutube.ru/video/(\w*)/}
      ]
    end

    def self.oembed_endpoint
      'http://rutube.ru/api/oembed/'
    end

    def initialize(url, options = {})
      @url = url
      @options = options.merge({ format: :json })
    end

    def clean_url
      @clean_url ||= "http://rutube.ru/video/#{id}/"
    end

  end
end
