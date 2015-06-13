class SnowEvent < ActiveRecord::Base
  belongs_to :user
  belongs_to :ski_resort

  validates_numericality_of :threshold
  validates_inclusion_of :contact_by, in: %w(call text)

  after_initialize :init

  def init
    self.contact_by ||= 'call'
  end

  def contacted_today?
    Time.now.all_day.cover? last_contacted if last_contacted
  end

  def contactable_time?
    [(Time.now.at_midnight + 8.hours)..(Time.now.at_midnight + 14.hours)].include? Time.now
  end

  def make_contact
    SnowContactWorker.perform_async(
      phone_number,
      contact_by_text? ? :text : :call,
      ski_resort_id
    )
    self.last_contacted = Time.now
    save
  end

  def contact_by_text?
    contact_by == 'text'
  end
end
