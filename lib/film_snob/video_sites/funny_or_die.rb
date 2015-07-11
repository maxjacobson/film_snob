require "film_snob/video_site"

class FilmSnob
  class FunnyOrDie < VideoSite
    def self.valid_url_patterns
      [
        %r{http://www.funnyordie.com/videos/([\w\d]+)}
      ]
    end

    def self.oembed_endpoint
      "http://www.funnyordie.com/oembed.json"
    end

    def clean_url
      @clean_url ||= "http://www.funnyordie.com/videos/#{id}"
    end
  end
end
