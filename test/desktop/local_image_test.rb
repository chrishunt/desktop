require 'test_helper'
require 'desktop/local_image'

module Desktop
  describe LocalImage do
    describe '#data' do
      it 'returns the image data' do
        image = Tempfile.new(%w[image .png])
        image.write 'image content'
        image.rewind

        assert_equal 'image content', LocalImage.new(image.path).data

        image.unlink
      end
    end
  end
end
