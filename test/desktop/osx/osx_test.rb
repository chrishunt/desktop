require 'test_helper'
require 'desktop/osx/osx'
require 'desktop/local_image'

module Desktop
  describe OSX do
    def osx
      desktop = Tempfile.new(%w[desktop .jpg])
      cached  = Tempfile.new(%w[cached .jpg])
      image   = Tempfile.new(%w[image .jpg])

      osx = OSX.new(
        :desktop_image_path => desktop.path,
        :cached_image_path  => cached.path,
        :skip_reload        => true,
        :skip_database      => true
      )

      yield osx, desktop, cached, image
    ensure
      desktop.unlink
      cached.unlink
      image.unlink
    end

    describe '#desktop_image=' do
      it 'removes the cached desktop image' do
        osx do |osx, _, cached, image|
          osx.desktop_image = LocalImage.new(image)
          refute File.exists?(cached.path)
        end
      end

      it 'raises DesktopImagePermissionsError when desktop is readonly' do
        osx do |osx, desktop, _, image|
          FileUtils.chmod 'a-w', desktop

          assert_raises OSX::DesktopImagePermissionsError do
            osx.desktop_image = LocalImage.new(image)
          end
        end
      end

      it 'raises DesktopImageMissingError when new image is missing' do
        osx do |osx, _, _, _|
          assert_raises OSX::DesktopImageMissingError do
            osx.desktop_image = LocalImage.new('/invalid/image/path.jpg')
          end
        end
      end
    end
  end
end
