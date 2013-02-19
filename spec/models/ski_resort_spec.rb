require 'spec_helper'

describe SkiResort do
  context '#contact_message' do
    let(:ski_resort) { build(:ski_resort) }
    let(:message) { ski_resort.contact_message }
    it 'produces a message' do
      expect(message).to be_kind_of String
    end
    it 'has the value' do
      message =~ /ski_resort.value/
    end
    it 'has the name' do
      message =~ /ski_resort.name/
    end
  end
end