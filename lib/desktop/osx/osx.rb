require 'desktop/osx/database'

module Desktop
  class OSX
    class DesktopImageMissingError < StandardError; end

    def self.desktop_image=(image)
      self.new.desktop_image = image
    end

    def initialize(options = nil)
      options ||= {}
      @skip_reload = options[:skip_reload]
      @skip_database = options[:skip_database]
      @desktop_image_path = \
        options[:desktop_image_path] || default_desktop_image_path
    end

    def desktop_image=(image)
      write_desktop image
      save_image_path_in_database unless skip_database
      reload_desktop unless skip_reload
    rescue Errno::ENOENT => e
      raise DesktopImageMissingError.new(e)
    end

    private

    attr_reader :desktop_image_path,
                :skip_reload,
                :skip_database

    def write_desktop(image)
      File.open(desktop_image_path, 'w') do |desktop|
        desktop.write image.data
      end
    end

    def save_image_path_in_database
      db = Database.new
      db.clear_desktop_image
      db.set_desktop_image desktop_image_path
      db.close
    end

    def reload_desktop
      system 'killall Dock'
    end

    def default_desktop_image_path
      File.expand_path "~/Library/Application Support/desktop-gem-wallpaper.jpg"
    end
  end
end
