require "film_snob/video_site"

class FilmSnob

  class Soundcloud < VideoSite

    def self.valid_url_patterns
      [ 
        %r{https?://soundcloud.com/([^/]+/.+)},
        %r{https?://m.soundcloud.com/([^/]+/.+)}
      ]
    end

    def self.oembed_endpoint
      "https://soundcloud.com/oembed"
    end

    def clean_url
      @clean_url ||= "https://soundcloud.com/#{id}"
    end

    def options
      {format: 'json'}.merge(@options)
    end

  end

end

