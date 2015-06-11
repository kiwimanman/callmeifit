namespace :resorts do
  desc 'Updates ski_resort values based on scraping'
  task update: :environment do
    Rake::Task['girl_friday:load'].invoke

    SkiResort.find_each do |resort|
      puts "Pushing #{resort.id}"
      ::RESORT_UPDATE_QUEUE.push(resort_id: resort.id)
    end

    Rake::Task['girl_friday:status'].invoke
  end
end

namespace :girl_friday do
  task load: :environment do
    # Stops the queues from actually processing jobs, do that in the unicorns!
    ENV['WORKER'] = 'false'

    require 'girl_friday/queues'
  end

  task status: :load do
    pp GirlFriday.status
  end
end
