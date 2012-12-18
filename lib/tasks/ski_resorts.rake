namespace :resorts do
  desc "Updates ski_resort values based on scraping"
  task :update => :environment do
    SkiResort.find_each do |resort|
      puts "Pushing #{resort.id}"
      RESORT_UPDATE_QUEUE.push(:resort_id => resort.id)
      puts "Done pushing #{resort.id}"
    end
  end
end