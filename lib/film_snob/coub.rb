require "film_snob/video_site"

class FilmSnob
  class Coub < VideoSite

    def self.valid_url_patterns
      [
        %r{https?://coub.com/view/(\w*)}
      ]
    end

    def clean_url
      @clean_url ||= "http://coub.com/view/#{id}"
    end

    def self.oembed_endpoint
      'http://coub.com/api/oembed.json'
    end
  end
end
