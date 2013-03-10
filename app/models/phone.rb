class Phone < ActiveRecord::Base
  belongs_to :user
  has_many :snow_events

  validates_numericality_of :international
  validates_numericality_of :number,    allow_nil: true
  validates_numericality_of :extension, allow_nil: true
  validates_length_of :number, is: 10
  validates_presence_of :user, :number
  validates_inclusion_of :verified, :in => [true, false]

  def initialize(params = {})
    super(params)

    self.international ||= 1
    self.verified      ||= false
  end

  def verified?
    verified
  end

  def formatted
    "(#{number[0..2]}) #{number[3..5]}-#{number[6..9]}"
  end

  def twilio_formatted
    "+#{international}#{number}"
  end

  def generate_verification_token
    self.verification_token ||= 5.times.map{ Random.rand(10).to_s }.join
  end

  def verifation_confirmed?(value)
    self.verified = true if verification_token == value
    self.verified
  end

  def self.send_verification(msg)
    twilio_account = Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']).account

    phone = Phone.find(msg[:phone_id])

    if msg[:method] == :call
      twilio_account.calls.create(
        :from => ENV['TWILIO_PHONE'],
        :to => phone.twilio_formatted,
        :url => "http://www.callmeif.it/phones/with_code/#{phone.verification_token}.xml"
      )
    else
      twilio_account.sms.messages.create(
        :from => ENV['TWILIO_PHONE'],
        :to => phone.twilio_formatted,
        :body => "Your verfication code is: #{phone.verification_token}"
      )
    end
  end
end