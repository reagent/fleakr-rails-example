namespace :cover do 
  
  desc "Freeze the default Rake task into your Rails project"
  task :freeze => :environment do
    template_file    = File.dirname(__FILE__) + '/../lib/templates/cover.rake.template'
    destination_file = "#{Rails.root}/lib/tasks/cover.rake"

    if File.exist?(destination_file)
      puts "Destination file '#{destination_file}' already exists"
    else
      FileUtils.cp(template_file, destination_file)
    end
  end
  
end
