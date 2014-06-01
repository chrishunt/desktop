require 'test_helper'
require 'desktop/simple_desktops'

module Desktop
  describe SimpleDesktops do
    describe '#latest_image' do
      it 'returns the latest desktop image' do
        VCR.use_cassette('simple_desktops_latest') do
          assert_equal \
            'http://static.simpledesktops.com/Pixelmoon_by_ArMaNDJ.png',
            SimpleDesktops.new.latest_image.path
        end
      end
    end
  end
end
