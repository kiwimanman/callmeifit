class Phone < ActiveRecord::Base
  belongs_to :user

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

  def twilio_formatted
    "+#{international}#{number}"
  end

  def generate_verification_token
    self.verification_token ||= 5.times.map{ Random.rand(10).to_s }.join
  end
end