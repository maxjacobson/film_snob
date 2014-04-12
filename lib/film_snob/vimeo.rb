require "film_snob/video_site"

class FilmSnob
  class Vimeo < VideoSite

    def self.valid_url_patterns
      [
        %r{https?://vimeo.com/(\d{1,})},
        %r{https?://vimeo.com/m/(\d{1,})},
        %r{https?://vimeo.com/couchmode/\w+/[\w:]+/(\d{1,})}
      ]
    end

    def clean_url
      "https://vimeo.com/#{id}"
    end

  end
end
