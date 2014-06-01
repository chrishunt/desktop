require 'test_helper'
require 'desktop/image'

module Desktop
  describe Image do
    describe '#filename' do
      it 'returns the image filename' do
        assert_equal 'image.png', Image.new('/path/to/image.png').filename
        assert_equal 'image.png', Image.new('http://abc.com/image.png').filename
      end
    end

    describe '#data' do
      it 'needs to be implemented' do
        assert_raises NotImplementedError do
          Image.new('/path/to/image').data
        end
      end
    end
  end
end
