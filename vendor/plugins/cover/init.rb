begin
  require 'rcov/rcovtask'
  require File.dirname(__FILE__) + '/lib/cover'
rescue LoadError
  puts "Make sure you have the rcov gem installed (gem install relevance-rcov --source=http://gems.github.com)"
end

