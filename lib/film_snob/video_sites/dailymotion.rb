require "film_snob/video_site"

class FilmSnob
  class Dailymotion < VideoSite
    def self.valid_url_patterns
      [
        %r{https?://www.dailymotion.com/video/([\w\d\-_]+)},
        %r{https?://touch.dailymotion.com/video/([\w\d\-_]+)}
      ]
    end

    def clean_url
      @clean_url ||= "https://www.dailymotion.com/video/#{id}"
    end

    def self.oembed_endpoint
      "http://www.dailymotion.com/services/oembed"
    end
  end
end
