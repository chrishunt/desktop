require 'test_helper'
require 'desktop/cli'

module Desktop
  describe CLI do
    def cli(*args)
      desktop = Tempfile.new(%w[desktop .jpg])
      desktop.write 'Default content'
      desktop.rewind

      CLI.start Array(args) + [
        "--default-image-path=#{desktop.path}"
      ]

      yield desktop
    ensure
      desktop.unlink
    end

    def with_new_image
      image = Tempfile.new(%w[image .jpg])
      image.write 'New content'
      image.rewind

      yield image
    ensure
      image.unlink
    end

    it 'sets the desktop when an image path is provided' do
      with_new_image do |image|
        cli 'set', image.path do |desktop|
          assert_equal File.read(desktop), File.read(image)
        end
      end
    end
  end
end
