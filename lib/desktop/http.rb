require 'faraday'
require 'uri'

module Desktop
  class HTTP
    def self.connection
      Faraday
    end

    def self.uri?(path)
      %w[http https].include? URI.parse(path).scheme
    rescue URI::BadURIError, URI::InvalidURIError
      false
    end
  end
end
