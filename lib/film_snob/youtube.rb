class FilmSnob
  class YouTube < VideoSite

    def self.valid_url_patterns
      [
        %r{https?://(?:(?:www|m).)?youtube.com/watch\?v=([\w\d]+)},
        %r{https?://(?:(?:www|m).)?youtu.be/([\w\d]+)}
      ]
    end

    def clean_url
      "https://www.youtube.com/watch?v=#{id}"
    end

  end
end
