require "film_snob/video_site"

class FilmSnob
  class Rdio < VideoSite

    def self.valid_url_patterns
      [
        /http?:\/\/www.rdio.com\/([\w\d\-_]+)\/([\w\d\-_]+\/album\/)/
        # %r{https?://touch.dailymotion.com/video/([\w\d\-_]+)},
        # http://www.rdio.com/artist/Sam_Smith/album/In_The_Lonely_Hour/
      ]
    end

    def clean_url
      @clean_url = url 
    end

    def self.oembed_endpoint
      'http://www.rdio.com/api/oembed/'
    end

  end
end
