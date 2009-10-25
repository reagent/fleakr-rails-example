require 'vendor/plugins/cover/init'

# Basic task to enable checking for code coverage
Cover::Task.new

# If you need to configure the task further, you can:
#
# * Add task dependencies to the constructor that get run each time
# * Enable verbosity
# * Change the enforcement threshold
# 
#   Cover::Task.new('db:migrate:reset', 'db:seed') do |t|
#     t.verbose = false
#     t.threshold = 100
#   end
#
# See the README file for more information
#