require 'test_helper'

module Cover
  class TaskTest < Test::Unit::TestCase
    
    context "An instance of the Task class" do
      setup do
        Task.any_instance.stubs(:define_tasks)
        @task = Task.new
      end
      
      should "have a list of dependencies by default" do
        @task.dependencies.should == ['cover:environment', 'db:migrate:reset']
      end
      
      should "be able to assign a dependency" do
        t = Task.new('foobar')
        t.dependencies.should == ['cover:environment', 'foobar']
      end
      
      should "be able to assign multiple dependencies" do
        t = Task.new('foobar', 'blingbling')
        t.dependencies.should == ['cover:environment', 'foobar', 'blingbling']
      end
      
      should "have a default threshold" do
        @task.threshold.should == 95
      end
      
      should "be able to set the threshold" do
        @task.threshold = 100
        @task.threshold.should == 100
      end
      
      should "convert thresholds above 100" do
        @task.threshold = 101
        @task.threshold.should == 100
      end
      
      should "convert thresholds below 1" do
        @task.threshold = 0
        @task.threshold.should == 1
      end
      
      should "have a default verbosity" do
        @task.verbose.should be(false)
      end
      
      should "be able to configure the verbosity" do
        @task.verbose = true
        @task.verbose.should be(true)
      end
      
      should "know the test path" do
        Rails.stubs(:root).with().returns('/root')
        @task.path.should == '/root/test'
      end
          
      should "know the directories to ignore" do
        @task.ignore.should == %w(fixtures factories shoulda_macros performance)
      end

      should "know the directories to exclude" do
        Gem.stubs(:path).with().returns(['gempath'])
        @task.exclude.sort.should == %w(gempath /Library/Ruby /usr/lib/ruby).sort
      end
      
      should "eliminate duplicates in exclude paths" do
        Gem.stubs(:path).with().returns(['/usr/lib/ruby'])
        @task.exclude.sort.should == %w(/Library/Ruby /usr/lib/ruby).sort
      end
      
      should "know the path to the output directory" do
        Rails.stubs(:root).with().returns('/root')
        @task.output_path.should == '/root/coverage'
      end
      
      should "know how to generate the options for RCov" do
        @task.stubs(:exclude).with().returns(['one', 'two'])
      
        options = ['--rails', '--text-report', "-x 'one'", "-x 'two'"]
      
        @task.options.sort.should == options.sort
      end
      
      context "with a test directory" do
        setup do
          @fs = setup_filesystem do |root|
            root.dir 'fixtures'
            root.dir 'unit'
            root.dir 'functional'
            root.dir 'helpers'
            root.dir 'shoulda_macros'
            root.file 'test_helper.rb'
          end
          @task.stubs(:path).with().returns(@fs.path)
        end
      
        teardown { @fs.destroy! }
      
        should "know the directories to include" do
          @task.directories.sort.should == %w(unit functional helpers).sort
        end
      
        should "know the test files" do
          FileList.stubs(:[]).with(
            "#{@fs.path}/functional/**/*_test.rb", "#{@fs.path}/helpers/**/*_test.rb", "#{@fs.path}/unit/**/*_test.rb"
          ).returns('files')
        
          @task.test_files.should == 'files'
        end
      end
      
    end
    
  end
end