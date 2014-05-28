require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'vcr'

# add lib to load path
$LOAD_PATH.unshift 'lib'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures'
  c.hook_into :webmock
end
