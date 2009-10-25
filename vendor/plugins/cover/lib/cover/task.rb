module Cover
  
  # = Task
  #
  # Defines the necessary Rake tasks for using this in your Rails project.
  #
  class Task
    
    attr_writer :verbose
    
    # Create the task with optional dependencies:
    #
    #   Cover::Task.new('dependency_one', 'dependency_two')
    #
    def initialize(*dependencies)
      self.dependencies = dependencies
      yield self if block_given?
      define_tasks
    end

    def default_dependencies # :nodoc:
      ['cover:environment']
    end
    
    def dependencies=(dependencies) # :nodoc:
      if !dependencies.empty?
        @dependencies = default_dependencies + dependencies
      end
    end
    
    def dependencies # :nodoc:
      @dependencies || default_dependencies + ['db:migrate:reset']
    end
    
    # Configure the threshold for ensuring coverage, defaults to 95%
    #
    def threshold=(threshold)
      @threshold = threshold
      
      @threshold = 100 if threshold > 100
      @threshold = 1   if threshold < 1
    end
    
    # The currently configured threshold
    #
    def threshold
      @threshold || 95
    end
    
    # Configure the verbosity of this report
    #
    def verbose
      @verbose || false
    end
    
    def path # :nodoc:
      "#{Rails.root}/test"
    end
    
    def ignore # :nodoc:
      %w(fixtures factories shoulda_macros performance)
    end
    
    def exclude # :nodoc:
      (Gem.path + ['/Library/Ruby', '/usr/lib/ruby']).uniq
    end
    
    def output_path # :nodoc:
      "#{Rails.root}/coverage"
    end
    
    def options # :nodoc:
      options = Array.new
      options << '--rails'
      options << '--text-report'
      options << exclude.map {|x| "-x '#{x}'" }

      options.flatten
    end
    
    def directories # :nodoc:
      full_paths = Dir["#{path}/*"].select {|p| File.directory?(p) }
      directories = full_paths.map {|d| d.sub("#{path}/", '') }

      directories - ignore
    end
    
    def test_files # :nodoc:
      patterns = directories.map {|d| "#{path}/#{d}/**/*_test.rb" }
      FileList[*patterns]
    end
    
    def define_tasks # :nodoc:
      namespace :cover do 
        
        task :environment do
          ENV['RAILS_ENV'] = 'test'
          RAILS_ENV.replace('test')
        end

        Rcov::RcovTask.new(:coverage => dependencies) do |t|
          t.libs       = ['test']
          t.test_files = test_files
          t.verbose    = verbose
          t.rcov_opts  = options
          t.output_dir = output_path
        end

        desc "Ensure code coverage at or above configured threshold"
        task :ensure => 'cover:coverage' do
          report_file = "#{output_path}/index.html"

          report = Cover::Report.new(report_file, threshold)
          report.ensure!
        end
        
      end
      
      desc "Run the cover:ensure task in the CruiseControl environment"
      task :cruise => 'cover:ensure'
      
    end
    
  end
end