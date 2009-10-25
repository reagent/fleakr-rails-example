ENV["RAILS_ENV"] = "test"
$:.reject! { |e| e.include? 'TextMate' }
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

require "shoulda"
require "factory_girl"
require "mocha"
require "matchy"

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end
