require 'thor'
require 'desktop'

module Desktop
  class CLI < Thor
    desc 'set IMAGE_PATH', 'Set all desktops to the image at IMAGE_PATH'
    option :default_image_path
    def set(path)
      osx = OSX.new(options[:default_image_path])
      osx.desktop_image = LocalImage.new(path)
    end
  end
end
