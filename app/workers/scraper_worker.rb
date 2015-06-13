class ScraperWorker
  include Sidekiq::Worker

  def perform(resort_id)
    resort = SkiResort.find(resort_id)
    resort.scrape_value!
  end
end
