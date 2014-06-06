require 'test_helper'
require 'desktop/osx/database'

module Desktop
  describe OSX::Database do
    def with_connection
      connection = SQLite3::Database.new ':memory:'
      yield connection
    ensure
      connection.close
    end

    describe '#clear_desktop_image' do
      it 'clears contents of data table' do
        with_connection do |connection|
          connection.execute("CREATE TABLE data (FileName STRING)")
          connection.execute("INSERT INTO data VALUES ('mydesktop.png')")

          refute_empty connection.execute("SELECT * FROM data")

          OSX::Database.new(connection).clear_desktop_image

          assert_empty connection.execute("SELECT * FROM data")
        end
      end
    end
  end
end
