require 'test_helper'
require 'desktop/simple_desktops'

module Desktop
  describe SimpleDesktops do
    describe '#latest' do
      it 'returns the url for the latest desktop image' do
        assert_equal \
          'http://static.simpledesktops.com/uploads/desktops/2014/05/16/Pixelmoon_by_ArMaNDJ.png',
          SimpleDesktops.new.latest
      end
    end
  end
end
