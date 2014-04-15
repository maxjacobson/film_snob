require "film_snob/vimeo"
require "film_snob/youtube"
require "film_snob/hulu"

class FilmSnob
  class UrlToVideo

    VIDEO_SITES = [
      Vimeo,
      YouTube,
      Hulu
    ]

    attr_reader :url, :options

    def initialize(url, options)
      @url = url
      @options = options
    end

    def video
      site.nil?? nil : site.new(url, options)
    end

    private

      def site
        @site ||= VIDEO_SITES.find do |site|
          site.valid_url_patterns.any? do |pattern|
            pattern.match(url)
          end
        end
      end

  end
end
