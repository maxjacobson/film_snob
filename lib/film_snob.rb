require "film_snob/version"
require "film_snob/url_to_video"
require "film_snob/exceptions"

class FilmSnob
  attr_reader :url, :video

  def initialize(url)
    @url = url
    @video = FilmSnob::UrlToVideo.new(url).video
  end

  def watchable?
    !video.nil?
  end

  def method_missing(m)
    if [:site, :id, :clean_url, :title, :html].include?(m)
      complain_about_bad_urls!(m)
      video.send(m)
    else
      super
    end
  end

  private

    def complain_about_bad_urls!(method)
      raise NotSupportedURLError.new("Can not call FilmSnob##{method} because #{url} is not a supported URL.") unless watchable?
    end

end

