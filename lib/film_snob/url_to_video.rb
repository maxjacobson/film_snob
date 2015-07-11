Dir[File.join(File.dirname(__FILE__), "video_sites", "*.rb")].each do |file|
  require file
end

class FilmSnob
  class UrlToVideo
    attr_reader :url, :options

    def initialize(url, options)
      @url = url
      @options = options
    end

    def video
      site.nil? ? nil : site.new(url, options)
    end

    private

    def site
      @site ||= VideoSite.subclasses.find do |site|
        site.valid_url_patterns.any? do |pattern|
          pattern.match(url)
        end
      end
    end
  end
end
