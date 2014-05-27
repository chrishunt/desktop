require 'faraday'
require 'nokogiri'

module Desktop
  class SimpleDesktops
    def latest
      thumbnail.match(/http.*?png/).to_s
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
