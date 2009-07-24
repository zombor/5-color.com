use Rack::ShowExceptions
use Rack::Static, :urls => ['/css', '/images']
use Rack::Session::Cookie

PICOMBO = File.expand_path(Dir.getwd) + '/'
APPPATH = PICOMBO + 'application/'
SYSPATH = PICOMBO + 'system/'
EXTPATH = PICOMBO + 'extensions/'

$LOAD_PATH.unshift(APPPATH)
$LOAD_PATH.unshift(SYSPATH)

# app better be defined in here!
require 'bootstrap.rb'

run run_system()
