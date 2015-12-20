# require "net/http"
# require "json"
# TODO: follow redirects at least once to make instagram green
# TODO: stop reading instance variables
# TODO: add specs? I think yes... should surface whether we need to require
# net/http and json

require 'pry'

class FilmSnob
  class HTTPahty
    TUNNEL_MAX = 3

    def initialize(media, options = {})
      @media = media
      @options = options
    end

    def to_h(tunnel_count = 0)
      return @h if defined?(@h)

      @h = if response.code.start_with?("2")
             JSON.parse(response.body)
           elsif response.code.start_with?("3")
             if tunnel_count >= TUNNEL_MAX
               raise
               {}
             else
               self.class.new(@media, @options).override_uri(response['location']).to_h(tunnel_count + 1)
             end
           else
             {}
           end
    end

    def override_uri(location)
      @override_uri = URI.parse(location)
      self
    end

    private

    def response
      http.request(get)
    end

    def get
      Net::HTTP::Get.new(uri.request_uri)
    end

    def http
      Net::HTTP.new(meta_uri.host, meta_uri.port).tap do |uri|
        uri.use_ssl = use_ssl?
      end
    end

    def meta_uri
      URI.parse(@media.class.oembed_endpoint)
    end

    def use_ssl?
      "https" == meta_uri.scheme
    end

    def uri
      return @override_uri if @override_uri
      URI(@media.class.oembed_endpoint).tap do |uri|
        uri.query = URI.encode_www_form({
          :url => @media.clean_url }.merge(@options))
      end
    end
  end
end
