require 'desktop/image'

module Desktop
  class LocalImage < Image
    def data
      File.read path
    end
  end
end
