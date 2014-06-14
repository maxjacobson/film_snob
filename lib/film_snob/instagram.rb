require "film_snob/video_site"

class FilmSnob
  class Instagram < VideoSite
    def self.valid_url_patterns
      [
        %r{https?://(?:(?:www).)?instagram.com/p/(\w+)},
        %r{https?://(?:(?:www).)?instagr.am/p/(\w+)}
      ]
    end

    def self.oembed_endpoint
      'http://api.instagram.com/oembed'
    end

    def clean_url
      @clean_url ||= "http://instagram.com/p/#{id}"
    end

    def html
      # instagram's oembed response does not include html, so we need to construct it
      # but first we need to ensure that the response was good
      # which we do by checking for the presence of the title,
      # which will raise an exception if it's not present
      title && %{<iframe src="//instagram.com/p/#{id}/embed/" width="612" height="710" frameborder="0" scrolling="no" allowtransparency="true"></iframe>}
    end
  end
end
