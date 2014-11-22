require 'test_helper'
require 'desktop/osx/osx'
require 'desktop/local_image'

module Desktop
  describe OSX do
    def osx
      desktop = Tempfile.new(%w[desktop .jpg])
      image   = Tempfile.new(%w[image .jpg])

      osx = OSX.new(
        :desktop_image_path => desktop.path,
        :skip_reload        => true,
        :skip_database      => true
      )

      # stub out default_cache_path so system is modified during tests
      def osx.default_cached_desktop_path
        cache   = Tempfile.new(%w[cache .png])
        cache.path
      end

      yield osx, desktop, image
    ensure
      desktop.unlink
      image.unlink
    end

    describe '#desktop_image=' do
      it 'raises DesktopImagePermissionsError when desktop is readonly' do
        osx do |osx, desktop, image|
          FileUtils.chmod 'a-w', desktop

          assert_raises OSX::DesktopImagePermissionsError do
            osx.desktop_image = LocalImage.new(image)
          end
        end
      end

      it 'raises DesktopImageMissingError when new image is missing' do
        osx do |osx, _, _|
          assert_raises OSX::DesktopImageMissingError do
            osx.desktop_image = LocalImage.new('/invalid/image/path.jpg')
          end
        end
      end

      it 'ensure clean up cache admin png' do
        osx do |osx, desktop, image|
          assert_equal File.file?(osx.default_cached_desktop_path), true

          assert_send [osx, :remove_cached_desktop_png] do
            osx.desktop_image = LocalImage.new(image)
            assert_equal File.file?(osx.default_cached_desktop_path), false
          end
        end
      end
    end
  end
end
