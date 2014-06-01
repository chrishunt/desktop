require 'thor'
require 'desktop'

module Desktop
  class CLI < Thor
    desc 'set IMAGE_PATH', 'Set all desktops to the image at IMAGE_PATH'
    long_desc <<-LONGDESC
      `desktop set` will set the desktop image of all spaces on all monitors to
      the image at `IMAGE_PATH`.

      > $ desktop set /path/to/image.png
    LONGDESC
    option :default_image_path, :hide => true
    def set(path)
      osx = OSX.new(options[:default_image_path])
      osx.desktop_image = LocalImage.new(path)
    end
  end
end
