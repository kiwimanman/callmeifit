namespace :resorts do
  desc "Updates ski_resort values based on scraping"
  task :update => :environment do
    # Stops the queues from actually processing jobs, do that in the unicorns!
    ENV["WORKER"] = 'false'

    require 'girl_friday/queues'
    
    SkiResort.find_each do |resort|
      puts "Pushing #{resort.id}"
      ::RESORT_UPDATE_QUEUE.push(:resort_id => resort.id)

      puts GirlFriday.status
    end
  end
end