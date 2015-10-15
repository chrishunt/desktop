require 'thor'
require 'desktop'

module Desktop
  class CLI < Thor
    desc 'set IMAGE_PATH', 'Set all desktops to the image at IMAGE_PATH'
    long_desc <<-LONGDESC
      `desktop set` will set the desktop image of all spaces on all monitors to
      the image at `IMAGE_PATH`.

      > $ desktop set /path/to/image.png

      `IMAGE_PATH` can be a local file path or a URL.

      > $ desktop set http://url.to/image.jpg
    LONGDESC
    option :desktop_image_path, :hide => true
    option :skip_reload, :type => :boolean, :hide => true
    option :skip_database, :type => :boolean, :hide => true
    def set(path)
      osx = OSX.new(options)
      image = HTTP.uri?(path) ? WebImage.new(path) : LocalImage.new(path)

      begin
        osx.desktop_image = image
      rescue OSX::DesktopImageMissingError
        fail_with_missing_image_error image
      end
    end

    desc 'version', 'Show gem version'
    def version
      puts Desktop::VERSION
    end

    private

    def fail_with_missing_image_error(image)
      puts "Sorry, but it looks like the image you provided does not exist:"
      puts
      puts image.path
      puts
      puts "Please create an issue if you think this is my fault:"
      puts
      puts "https://github.com/chrishunt/desktop/issues/new"
      abort
    end
  end
end
