module Desktop
  class Image
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def filename
      File.basename path
    end

    def data
      raise NotImplementedError
    end
  end
end
