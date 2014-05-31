require 'nokogiri'
require 'desktop/http'
require 'desktop/image'

module Desktop
  class SimpleDesktops
    def latest_image
      @latest_image ||= Image.new(thumbnail.match(full_image_regex).to_s)
    end

    private

    def url
      'http://simpledesktops.com'
    end

    def html
      Nokogiri::HTML HTTP.get(url).body
    end

    def thumbnail
      html.css('.desktop a img').first['src']
    end

    # http://rubular.com/r/UHYgmPJoQM
    def full_image_regex
      /http.*?png/
    end
  end
end
