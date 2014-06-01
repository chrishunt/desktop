require 'test_helper'
require 'desktop/web_image'

module Desktop
  describe WebImage do
    describe '#data' do
      it 'returns the image data' do
        VCR.use_cassette('web_image_data') do
          url = 'http://f.cl.ly/items/233u2R2a2j0n403z0W1y/20130427.jpg'
          refute_nil WebImage.new(url).data
        end
      end
    end
  end
end
