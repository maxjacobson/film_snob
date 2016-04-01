require "forwardable"
require "film_snob/version"
require "film_snob/url_to_oembed_provider"
require "film_snob/exceptions"

class FilmSnob
  extend Forwardable

  MEDIA_METHODS = [:site, :id, :clean_url, :title, :html].freeze

  def_delegators :media, *MEDIA_METHODS

  attr_reader :url

  def initialize(url, options = {})
    @url = url
    @media = UrlToOembedProvider.new(url, options).media
  end

  def embeddable?
    !@media.nil?
  end

  private

  def media
    if embeddable?
      @media
    else
      raise NotSupportedURLError, "#{url} is not a supported URL"
    end
  end
end
