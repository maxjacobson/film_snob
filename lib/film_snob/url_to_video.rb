require "film_snob/coub"
require "film_snob/funny_or_die"
require "film_snob/hulu"
require "film_snob/instagram"
require "film_snob/vimeo"
require "film_snob/youtube"

class FilmSnob
  class UrlToVideo

    VIDEO_SITES = [
      Vimeo,
      YouTube,
      Hulu,
      FunnyOrDie,
      Coub,
      Instagram
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
