require "film_snob/video_site"

class FilmSnob
  class Rdio < VideoSite

    def self.valid_url_patterns
      [
        /rdio/
        # %r{https?://touch.dailymotion.com/video/([\w\d\-_]+)},
        # http://www.rdio.com/artist/Sam_Smith/album/In_The_Lonely_Hour/
      ]
    end

    # def clean_url
    #   @clean_url ||= "https://www.dailymotion.com/video/#{id}"
    # end

    # def self.oembed_endpoint
    #   'http://www.dailymotion.com/services/oembed'
    # end

  end
end
