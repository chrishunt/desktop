require 'faraday'
require 'nokogiri'

module Desktop
  class SimpleDesktops
    def latest_image_url
      thumbnail.match(/http.*?png/).to_s
    end

    def latest_image
      http.get(latest_image_url).body
    end

    private

    def http
      Faraday
    end

    def url
      'http://simpledesktops.com'
    end

    def body
      http.get(url).body
    end

    def parser
      Nokogiri::HTML(body)
    end

    def thumbnail
      parser.css('.desktop a img').first['src']
    end
  end
end
