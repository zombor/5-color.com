require 'test/unit'
require 'yaml'
require '../core/core'

class TestConfig < Test::Unit::TestCase
	def setup
		$LOAD_PATH.unshift(File.expand_path(Dir.getwd+'../..')+'/')
		$LOAD_PATH.unshift(File.expand_path(Dir.getwd+'../../../application')+'/')
	end

	def test_base
		assert_equal('http://localhost:4000/', Picombo::Url.base())
	end
end