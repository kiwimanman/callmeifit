class SkiResort < ActiveRecord::Base
  has_many :snow_events

  def scrape_value!
    scrape = Nokogiri::HTML(open(scrape_url))
    scraped_value = scrape.at_css(scrape_selector).children.first.text
    match = scraped_value.match(Regexp.new(scrape_regex))
    if match && match[:value]
      self.value = match[:value] 
      save
      SnowEvent.find_all_by_ski_resort_id(1).each do |event|
        if event.threshold <= value && event.contactable_time? && !event.contacted_today?
          event.make_contact
        end
      end
      logger.info "Saving scrape for #{name}"
    end
    logger.info "Ending scrape for #{name}"
  end

  def registered_by_user?(user)
    snow_events.find do |se|
      se.user_id == user.id
    end unless user.nil?
  end
end