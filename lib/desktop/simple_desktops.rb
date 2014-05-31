require 'faraday'
require 'nokogiri'

module Desktop
  class SimpleDesktops
    def latest_image_url
      thumbnail.match(full_image_regex).to_s
    end

    def latest_image
      http.get(latest_image_url).body
    end

    private

    def url
      'http://simpledesktops.com'
    end

    def html
      Nokogiri::HTML http.get(url).body
    end

    def thumbnail
      html.css('.desktop a img').first['src']
    end

    def http
      Faraday
    end

    # http://rubular.com/r/UHYgmPJoQM
    def full_image_regex
      /http.*?png/
    end
  end
end
