class SkiResort < ActiveRecord::Base
  has_many :snow_events

  def scrape_value!
    puts scrape_url
    scrape = Nokogiri::HTML(open(scrape_url))
    puts scrape
    scraped_value = scrape.at_css(scrape_selector).children.first.text
    puts scraped_value
    match = scraped_value.match(Regexp.new(scrape_regex))
    puts match
    if match && match[:value]
      self.value = match[:value] 
      save
      logger.info "Saving scrape for #{name}"
    end
    logger.info "Ending scrape for #{name}"
  end
end