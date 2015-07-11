require "forwardable"
require "film_snob/version"
require "film_snob/url_to_video"
require "film_snob/exceptions"
require "film_snob/deprecated"

class FilmSnob
  extend Deprecated, Forwardable

  VIDEO_METHODS = [:site, :id, :clean_url, :title, :html]

  def_delegators :video, *VIDEO_METHODS

  # TODO(2015-08-01): actually deprecate this method
  deprecated_alias :watchable?, :embeddable?, :removed_in => "v1.0.0"

  attr_reader :url

  def initialize(url, options = {})
    @url = url
    @video = UrlToVideo.new(url, options).video
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
