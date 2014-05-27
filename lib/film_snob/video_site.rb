require 'httparty'

class FilmSnob
  class VideoSite

    attr_reader :url, :options

    def initialize(url, options)
      @url = url
      @options = options
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

    def self.oembed_endpoint
      ''
    end

    def title
      oembed['title']
    end

    def html
      oembed['html'] || (raise NotEmbeddableError.new("#{clean_url} is not embeddable"))
    end

    private

      def matching_pattern
        self.class.valid_url_patterns.find do |pattern|
          pattern.match(url)
        end
      end

      def oembed
        @oembed ||= HTTParty.get(
          self.class.oembed_endpoint,
          query: { url: clean_url }.merge(options)
        )
      end

  end
end
