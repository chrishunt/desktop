require 'test_helper'
require 'desktop/simple_desktops'

module Desktop
  describe SimpleDesktops do
    describe '#latest_image_url' do
      it 'returns the url for the latest desktop image' do
        VCR.use_cassette('simple_desktops_latest') do
          assert_equal \
            'http://static.simpledesktops.com/Pixelmoon_by_ArMaNDJ.png',
            SimpleDesktops.new.latest_image_url
        end
      end
    end

    describe '#latest_image_filename' do
      it 'returns the filename for the latest desktop image' do
        VCR.use_cassette('simple_desktops_latest') do
          assert_equal \
            'Pixelmoon_by_ArMaNDJ.png',
            SimpleDesktops.new.latest_image_filename
        end
      end
    end
  end
end
