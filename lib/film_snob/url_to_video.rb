Dir[File.dirname(__FILE__) + '/video_sites/*.rb'].each { |site| puts site; require site }

class FilmSnob
  class UrlToVideo

    VIDEO_SITES = [
      Coub,
      Dailymotion,
      FunnyOrDie,
      Hulu,
      Instagram,
      Rutube,
      Vimeo,
      YouTube
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
