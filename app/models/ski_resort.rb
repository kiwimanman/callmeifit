class SkiResort < ActiveRecord::Base
  has_many :snow_events

  def scrape_value!
    logger.info "Starting scrape for #{name}"
    scrape = Nokogiri::HTML(open(scrape_url))
    scraped_value = scrape.at_css(scrape_selector).children.first.text
    match = scraped_value.match(Regexp.new(scrape_regex))

    if match && match[:value]
      self.value = match[:value] 
      save
      logger.info "Saving scrape for #{name}"
    end
    logger.info "Ending scrape for #{name}"
  end
end