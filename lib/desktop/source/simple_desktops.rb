require 'desktop/source/source'

module Desktop
  module Source
    class SimpleDesktops < Source
      private

      def source
        'http://simpledesktops.com'
      end

      def image_url
        thumbnail = html.css('.desktop a img').first['src']

        # http://rubular.com/r/UHYgmPJoQM
        thumbnail.match(/http.*?png/).to_s
      end
    end
  end
end
