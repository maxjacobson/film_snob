class FilmSnob
  class Hulu < VideoSite

    def self.valid_url_patterns
      [
        %r{https?://(?:(?:www).)?hulu.com/watch/(\d+)}
      ]
    end

    def clean_url
      "http://www.hulu.com/watch/#{id}"
    end

  end
end
