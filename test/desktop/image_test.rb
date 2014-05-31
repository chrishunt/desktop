require 'test_helper'
require 'desktop/image'

module Desktop
  describe Image do
    describe '#filename' do
      it 'returns the image filename' do
        image = Image.new('http://simpledesktops.com/Pixelmoon_by_ArMaNDJ.png')
        assert_equal 'Pixelmoon_by_ArMaNDJ.png', image.filename
      end
    end

    describe '#data' do
      it 'returns the file data for this image' do
        VCR.use_cassette('image_data') do
          url = 'http://f.cl.ly/items/233u2R2a2j0n403z0W1y/20130427.jpg'
          refute_nil Image.new(url).data
        end
      end
    end
  end
end
