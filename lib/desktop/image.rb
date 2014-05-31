require 'desktop/http'

module Desktop
  class Image
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def filename
      File.basename url
    end

    def data
      HTTP.get(url).body
    end
  end
end
