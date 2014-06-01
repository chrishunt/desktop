require 'test_helper'
require 'desktop/web_image'

module Desktop
  describe WebImage do
    describe '#data' do
      it 'returns the image data' do
        VCR.use_cassette('web_image_data') do
          refute_nil WebImage.new('http://f.cl.ly/image.jpg').data
        end
      end
    end
  end
end
