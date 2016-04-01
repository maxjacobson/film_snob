require "net/http"
require "json"

class FilmSnob
  class OembedProvider
    attr_reader :url, :options

    def initialize(url, options = {})
      @url = url
      @options = friendly_options(options)
      ensure_match unless options.delete(:matched)
    end

    def id
      @id ||= matching_pattern.match(url)[1]
    end

    def site
      @site ||= self.class.to_s.split("::").last.downcase.to_sym
    end

    class << self
      def inherited(base)
        subclasses << base
      end

      def valid_url_patterns
        []
      end

      def oembed_endpoint
        ""
      end

      def http
        Net::HTTP.new(uri.host, uri.port).tap do |uri|
          uri.use_ssl = use_ssl?
        end
      end

      def use_ssl?
        "https" == uri.scheme
      end

      def subclasses
        @subclasses ||= []
      end

      private

      def uri
        URI.parse(oembed_endpoint)
      end
    end

    def title
      lookup :title
    end

    def html
      lookup :html
    end

    private

    def not_embeddable!
      raise NotEmbeddableError, "#{clean_url} is not embeddable"
    end

    def lookup(attribute)
      oembed[attribute.to_s] || not_embeddable!
    end

    def matching_pattern
      @matching_pattern ||= self.class.valid_url_patterns.find do |pattern|
        pattern.match(url)
      end
    end

    def oembed
      @oembed ||= begin
                    if response.code.start_with?("2")
                      JSON.parse(response.body)
                    else
                      {}
                    end
                  end
    end

    def response
      @response ||= self.class.http.request get
    end

    def get
      Net::HTTP::Get.new uri.request_uri
    end

    def uri
      URI(self.class.oembed_endpoint).tap do |uri|
        uri.query = URI.encode_www_form({ :url => clean_url }.merge(options))
      end
    end

    def ensure_match
      return unless matching_pattern.nil?
      raise NotSupportedURLError, "#{self.class} can not handle #{url.inspect}"
    end

    # a subclass can override this one to define some aliases to paper over some
    # quirks in a specific oembed provider's API, e.g. mapping "width" to
    # "maxwidth"
    def friendly_options(options)
      options
    end
  end
end
