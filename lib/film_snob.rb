require "film_snob/version"
require "film_snob/url_to_video"
require "film_snob/exceptions"
require "film_snob/deprecated"

class FilmSnob
  attr_reader :url

  extend Deprecated

  def initialize(url, options = {})
    @url = url
    @video = UrlToVideo.new(url, options).video
  end

  def embeddable?
    !@video.nil?
  end

  deprecated_alias :watchable?, :embeddable?, removed_in: "v1.0.0"

  def method_missing(message)
    if delegated_video_methods.include?(message)
      video.send(message)
    else
      super
    end
  end

  private

  def video
    if embeddable?
      @video
    else
      raise NotSupportedURLError, "#{url} is not a supported URL"
    end
  end

  def delegated_video_methods
    [:site, :id, :clean_url, :title, :html]
  end
end

