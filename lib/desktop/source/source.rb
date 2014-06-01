require 'nokogiri'
require 'desktop/http'
require 'desktop/web_image'

module Desktop
  module Source
    class Source
      def self.latest_image
        self.new.latest_image
      end

      def latest_image
        @latest_image ||= WebImage.new(image_url)
      end

      private

      def html
        Nokogiri::HTML HTTP.get(source).body
      end

      def source
        raise NotImplementedError
      end

      def image_url
        raise NotImplementedError
      end
    end
  end
end
