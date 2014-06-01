require 'sqlite3'

module Desktop
  class OSX
    attr_reader :desktop_image_path, :skip_reload
    class DesktopImagePermissionsError < StandardError; end

    def self.desktop_image=(image)
      self.new.desktop_image = image
    end

    def self.update_desktop_image_permissions
      self.new.update_desktop_image_permissions
    end

    def self.chown_command
      self.new.chown_command
    end

    def self.chmod_command
      self.new.chmod_command
    end

    def initialize(desktop_image_path = nil, skip_reload = false)
      @skip_reload = skip_reload
      @desktop_image_path = desktop_image_path || default_desktop_image_path
    end

    def desktop_image=(image)
      write_default_desktop image
      clear_custom_desktop_image
      reload_desktop unless skip_reload
    rescue Errno::EACCES => e
      raise DesktopImagePermissionsError.new(e)
    end

    def update_desktop_image_permissions
      system(chown_command) && system(chmod_command)
    end

    def chown_command
      "sudo chown root:staff #{desktop_image_path}"
    end

    def chmod_command
      "sudo chmod 664 #{desktop_image_path}"
    end

    private

    def write_default_desktop(image)
      File.open(desktop_image_path, 'w') do |desktop|
        desktop.write image.data
      end
    end

    def clear_custom_desktop_image
      db = SQLite3::Database.new(desktop_image_db_path)
      db.execute 'DELETE FROM data'
      db.execute 'VACUUM data'
      db.close
    end

    def reload_desktop
      system 'killall Dock'
    end

    def default_desktop_image_path
      '/System/Library/CoreServices/DefaultDesktop.jpg'
    end

    def desktop_image_db_path
      File.expand_path '~/Library/Application Support/Dock/desktoppicture.db'
    end
  end
end
