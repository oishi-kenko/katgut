require 'rails_helper'

RSpec.describe Toritsugi::Rule, type: :model do
  describe "validations" do
    let(:rule) { build(:rule) }

    it 'accept fulfilled object' do
      expect(rule).to be_valid
    end

    it 'doesn\'t allow source-less record' do
      rule.source = nil
      expect(rule).not_to be_valid
    end

    it 'doesn\'t allow null destination-less record' do
      rule.destination = nil
      expect(rule).not_to be_valid
    end
  end
end
