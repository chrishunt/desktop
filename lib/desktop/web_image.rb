require 'desktop/http'
require 'desktop/image'

module Desktop
  class WebImage < Image
    def data
      HTTP.get(path).body
    end
  end
end
