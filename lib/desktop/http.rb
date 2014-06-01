require 'faraday'

module Desktop
  class HTTP
    def self.connection
      Faraday
    end
  end
end
