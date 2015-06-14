namespace :resorts do
  desc "Updates ski_resort values based on scraping"
  task update: :environment do
    SkiResort.find_each do |resort|
      puts "Pushing #{resort.id}"
      ScraperWorker.perform_async(resort.id)
    end
  end
end
