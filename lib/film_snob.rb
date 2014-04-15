require "film_snob/version"
require "film_snob/url_to_video"
require "film_snob/exceptions"

class FilmSnob
  attr_reader :url, :video

  def initialize(url, options={})
    @url = url
    @video = UrlToVideo.new(url, options).video
  end

  def watchable?
    !video.nil?
  end

  def method_missing(message)
    if delegated_video_methods.include?(message)
      complain_about_bad_urls!(message)
      video.send(message)
    else
      super
    end
  end

  private
  
    def delegated_video_methods
      [:site, :id, :clean_url, :title, :html]
    end

    def complain_about_bad_urls!(method)
      raise NotSupportedURLError.new("Can not call FilmSnob##{method} because #{url} is not a supported URL.") unless watchable?
    end

end

