require 'test_helper'
require 'desktop/osx/database'

module Desktop
  describe OSX::Database do
    def with_connection
      connection = SQLite3::Database.new ':memory:'
      desktop_image = Tempfile.new(%w[desktop .jpg])
      yield connection, desktop_image.path
    ensure
      desktop_image.unlink
      connection.close
    end

    describe '#clear_desktop_image' do
      it 'clears contents of data table' do
        with_connection do |connection, _|
          connection.execute("CREATE TABLE data (FileName STRING)")
          connection.execute("INSERT INTO data VALUES ('mydesktop.png')")

          refute_empty connection.execute("SELECT * FROM data")

          OSX::Database.new(connection).clear_desktop_image

          assert_empty connection.execute("SELECT * FROM data")
        end
      end

      it 'does not blow up if data table does not exist' do
        with_connection do |connection, _|
          assert_empty connection.execute(
            "SELECT name FROM sqlite_master WHERE type='table' AND name='data'"
          )

          OSX::Database.new(connection).clear_desktop_image
        end
      end
    end

    describe '#set_desktop_image' do
      it 'fills the data table with entries for the new desktop image' do
        with_connection do |connection, desktop_image_path|
          connection.execute("CREATE TABLE data (value)")

          assert_empty connection.execute("SELECT * FROM data")

          OSX::Database.new(connection).set_desktop_image(desktop_image_path)

          assert_equal [[desktop_image_path]] * 100,
            connection.execute("SELECT * FROM data")
        end
      end

      it 'does not blow up if data table does not exist' do
        with_connection do |connection, desktop_image_path|
          assert_empty connection.execute(
            "SELECT name FROM sqlite_master WHERE type='table' AND name='data'"
          )

          OSX::Database.new(connection).set_desktop_image(desktop_image_path)
        end
      end
    end
  end
end
