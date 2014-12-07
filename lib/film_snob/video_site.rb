require "net/http"
require "json"

class FilmSnob
  class VideoSite
    attr_reader :url, :options
    def initialize(url, options = {})
      @url = url
      @options = options
    end

    def id
      @id ||= matching_pattern.match(url)[1]
    end

    def site
      @site ||= self.class.to_s.split("::").last.downcase.to_sym
    end

    SUBCLASSES = []
    def self.inherited(base)
      SUBCLASSES << base
    end

    def self.subclasses
      SUBCLASSES
    end

    def self.valid_url_patterns
      []
    end

    def self.oembed_endpoint
      ""
    end

    def self.http
      Net::HTTP.new(uri.host, uri.port).tap do |uri|
        uri.use_ssl = use_ssl?
      end
    end

    def self.use_ssl?
      "https" == uri.scheme
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

    def self.uri
      URI.parse(oembed_endpoint)
    end

    def lookup(attribute)
      oembed[attribute.to_s] || not_embeddable!
    end

    def matching_pattern
      self.class.valid_url_patterns.find do |pattern|
        pattern.match(url)
      end
    end

    def oembed
      @oembed ||= JSON.parse response.body
    rescue
      @oembed = {}
    end

    def response
      self.class.http.request get
    end

    def get
      Net::HTTP::Get.new uri.request_uri
    end

    def uri
      URI(self.class.oembed_endpoint).tap do |uri|
        uri.query = URI.encode_www_form({ url: clean_url }.merge(options))
      end
    end
  end
end

