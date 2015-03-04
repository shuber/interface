require 'rubygems'

if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start
end

require 'test/unit'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))
require 'interface'

Test::Unit::TestCase.class_eval do
  include Interface::TestHelper

  def assert_all_equal(expected, *results)
    results.each { |result| assert_equal expected, result }
  end
end
