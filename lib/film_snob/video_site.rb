class FilmSnob
  class VideoSite

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def id
      @id ||= matching_pattern.match(url)[1]
    end

    def site
      @site ||= self.class.to_s.split('::').last.downcase.to_sym
    end

    def self.valid_url_patterns
      []
    end

    private

      def matching_pattern
        self.class.valid_url_patterns.find do |pattern|
          pattern.match(url)
        end
      end

  end
end
