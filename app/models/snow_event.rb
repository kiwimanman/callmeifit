class SnowEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :ski_resort

  def contacted_today?
    Time.now.all_day.cover? last_contacted if last_contacted
  end

  def contactable_time?
    [(Time.now.at_midnight + 8.hours)..(Time.now.at_midnight + 14.hours)].include? Time.now
  end

  def make_contact
    ::SNOW_CONTACT_QUEUE.push(:phone => phone_number, :ski_resort => ski_resort_id)
    self.last_contacted = Time.now
    save
  end
end