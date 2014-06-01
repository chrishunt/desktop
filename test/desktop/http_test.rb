require 'test_helper'
require 'desktop/http'

module Desktop
  describe HTTP do
    describe '.uri?' do
      it 'returns true when path is a uri' do
        assert HTTP.uri? 'http://abc.com/image.jpg'
      end

      it 'returns false when path is not a uri' do
        refute HTTP.uri? '/path/to/image.jpg'
      end
    end
  end
end
