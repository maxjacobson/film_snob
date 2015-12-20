
require "film_snob/httpahty"

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
      @oembed ||= HTTPahty.new(self, options).to_h
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
