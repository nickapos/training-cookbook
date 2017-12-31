# add ../lib to the $LOAD_PATH so busser-serverspec can find the yarjuf lib
$LOAD_PATH << '../lib'
require 'busser/rubygems'
Busser::RubyGems.install_gem('yarjuf', '>0')

require 'yarjuf'
require 'serverspec'

RSpec.configure do |c|
  c.output_stream = File.open('/tmp/serverspec-result.xml', 'w')
  c.formatter = 'JUnit'
end
