require 'test_helper'
require 'desktop/cli'

module Desktop
  describe CLI do
    def with_defaults
      desktop = Tempfile.new(%w[desktop .jpg])
      desktop.write 'Default content'
      desktop.rewind

      cached = Tempfile.new(%w[cached .jpg])
      cached.write 'Cached content'
      cached.rewind

      image = Tempfile.new(%w[image .jpg])
      image.write 'New content'
      image.rewind

      defaults = [
        "--desktop-image-path=#{desktop.path}",
        "--cached-image-path=#{cached.path}",
        "--skip-reload",
        "--skip-database"
      ]

      yield desktop, cached, image, defaults
    ensure
      desktop.unlink
      cached.unlink
      image.unlink
    end

    it 'sets the desktop when a local image path is provided' do
      with_defaults do |desktop, _, image, defaults|
        CLI.start ['set', image.path] + defaults
        assert_equal File.read(desktop), File.read(image)
      end
    end

    it 'sets the desktop when a web url is provided' do
      with_defaults do |desktop, _, _, defaults|
        VCR.use_cassette('web_image_data') do
          CLI.start ['set', 'http://f.cl.ly/image.jpg'] + defaults
          refute_equal 'Default content', File.read(desktop)
        end
      end
    end
  end
end
