require "film_snob/video_site"

class FilmSnob
  class YouTube < VideoSite
    def self.valid_url_patterns
      [
        %r{
          https?://(?:(?:www|m).)?youtube.com/watch\?
          (?:feature=[\w\.]+&)?v=([\w\d\-_]+)
        }x,
        %r{https?://(?:(?:www|m).)?youtu.be/([\w\d\-_]+)},
        %r{https?://(?:(?:www|m).)?youtube.com/v/([\w\d\-_]+)}
      ]
    end

    def self.oembed_endpoint
      "https://www.youtube.com/oembed"
    end

    def clean_url
      @clean_url ||= "https://www.youtube.com/watch?v=#{id}"
    end
  end
end

