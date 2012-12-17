class Phone < ActiveRecord::Base
  belongs_to :user
  has_many :snow_events

  attr_accessible :number

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
end