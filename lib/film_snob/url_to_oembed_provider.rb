path_to_providers = File.join(File.dirname(__FILE__), "oembed_providers")
Dir.entries(path_to_providers).each do |file|
  require "film_snob/oembed_providers/#{file}" unless [".", ".."].include?(file)
end

class FilmSnob
  class UrlToOembedProvider
    attr_reader :url, :options

    def initialize(url, options)
      @url = url
      @options = options
    end

    def media
      site.nil? ? nil : site.new(url, options)
    end

    private

    def site
      @site ||= OembedProvider.subclasses.find do |site|
        site.valid_url_patterns.any? do |pattern|
          pattern.match(url)
        end
      end
    end
  end
end
