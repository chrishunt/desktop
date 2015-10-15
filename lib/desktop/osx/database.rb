require 'sqlite3'

module Desktop
  class OSX
    class Database
      attr_reader :connection

      def initialize(connection = nil)
        @connection = connection || default_connection
      end

      def clear_desktop_image
        clear if data?
      end

      def set_desktop_image(desktop_image_path)
        create unless data?

        ([desktop_image_path] * 100).each { |path| insert(path) }
      end

      def close
        connection.close
      end

      private

      def data?
        connection.execute(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='data'"
        ).any?
      end

      def insert(data)
        connection.execute 'INSERT INTO data (value) VALUES (?)', data
      end

      def clear
        connection.execute 'DELETE FROM data'
        connection.execute 'VACUUM data'
      end

      def create
        connection.execute 'CREATE TABLE data (value)'
        connection.execute 'CREATE INDEX data_index ON data (value)'
      end

      def default_connection
        SQLite3::Database.new path
      end

      def path
        File.expand_path '~/Library/Application Support/Dock/desktoppicture.db'
      end
    end
  end
end
