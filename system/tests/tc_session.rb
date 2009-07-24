require 'rubygems'
require 'rack/test'
require 'test/unit'
require 'yaml'
require 'erb'
require 'singleton'
require '../core/core'
require 'dm-core'

APPPATH = File.expand_path(Dir.getwd+'../../../application/')+'/'
SYSPATH = File.expand_path(Dir.getwd+'../../../system/')+'/'
EXTPATH = File.expand_path(Dir.getwd+'../../../extensions/')+'/'

class TestCookie < Test::Unit::TestCase
	include Rack::Test::Methods

	def setup
		$LOAD_PATH.unshift(SYSPATH)
		$LOAD_PATH.unshift(APPPATH)
	end

	def app
		Picombo::Core.new
	end

	def test_get
		get('/unittest')
		get('/unittest/test_session')
puts last_request.inspect
		assert_equal('foobar', Picombo::Session.instance.get('test'))
	end
end