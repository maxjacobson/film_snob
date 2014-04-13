require "film_snob/version"
require "film_snob/url_to_video"
require "film_snob/exceptions"

class FilmSnob
  attr_reader :url, :video

  def initialize(url)
    @url = url
    @video = FilmSnob::UrlToVideo.new(url).video
  end

  def site
    complain_about_bad_urls!(:site)
    video.site
  end

  def id
    complain_about_bad_urls!(:id)
    video.id
  end

  def clean_url
    complain_about_bad_urls!(:clean_url)
    video.clean_url
  end

  def watchable?
    !video.nil?
  end

  private

    def complain_about_bad_urls!(method)
      raise NotSupportedURLError.new("Can not call FilmSnob##{method} because #{url} is not a supported URL.") unless watchable?
    end

end

