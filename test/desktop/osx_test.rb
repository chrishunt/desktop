require 'test_helper'
require 'desktop/osx'
require 'desktop/local_image'

module Desktop
  describe OSX do
    def osx
      desktop = Tempfile.new(%w[desktop .jpg])
      image   = Tempfile.new(%w[image .jpg])
      osx     = OSX.new(desktop.path, true)

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
    end
  end
end
