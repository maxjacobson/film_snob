require "film_snob/video_site"

class FilmSnob
  class Instagram < VideoSite
    def self.valid_url_patterns
      [
        %r{http?://(?:(?:www).)?instagram.com/p/(\w+)},
        %r{http?://(?:(?:www).)?instagr.am/p/(\w+)}
      ]
    end

    def self.oembed_endpoint
      'http://api.instagram.com/oembed'
    end

    def clean_url
      @clean_url ||= "http://instagram.com/p/#{id}"
    end

    def html
      if id
        "<iframe src=\"//instagram.com/p/#{id}/embed/\" width=\"612\" height=\"710\" frameborder=\"0\" scrolling=\"no\" allowtransparency=\"true\"></iframe>"
      else
        raise NotEmbeddableError.new("#{clean_url} is not embeddable")
      end
    end
  end
end
