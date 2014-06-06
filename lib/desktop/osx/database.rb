require 'sqlite3'

module Desktop
  class OSX
    class Database
      attr_reader :connection

      def initialize(connection = nil)
        @connection = connection || default_connection
      end

      def clear_desktop_image
        clear_data
      end

      def close
        connection.close
      end

      private

      def clear_data
        connection.execute 'DELETE FROM data'
        connection.execute 'VACUUM data'
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
