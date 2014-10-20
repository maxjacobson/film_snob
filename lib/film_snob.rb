require "film_snob/version"
require "film_snob/url_to_video"
require "film_snob/exceptions"

class FilmSnob
  attr_reader :url

  def initialize(url, options = {})
    @url = url
    @video = UrlToVideo.new(url, options).video
  end

  def watchable?
    !@video.nil?
  end

  def method_missing(message)
    if delegated_video_methods.include?(message)
      video.send(message)
    else
      super
    end
  end

  private

  def video
    if watchable?
      @video
    else
      raise NotSupportedURLError, "#{url} is not a supported URL"
    end
  end

  def delegated_video_methods
    [:site, :id, :clean_url, :title, :html]
  end
end

