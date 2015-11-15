require "forwardable"
require "film_snob/version"
require "film_snob/url_to_oembed_provider"
require "film_snob/exceptions"

class FilmSnob
  extend Forwardable

  VIDEO_METHODS = [:site, :id, :clean_url, :title, :html]

  def_delegators :video, *VIDEO_METHODS

  attr_reader :url

  def initialize(url, options = {})
    @url = url
    @video = UrlToOembedProvider.new(url, options).video
  end

  def embeddable?
    !@video.nil?
  end

  private

  def video
    if embeddable?
      @video
    else
      raise NotSupportedURLError, "#{url} is not a supported URL"
    end
  end
end
