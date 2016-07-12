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

    it 'doesn\'t allow destination-less record' do
      rule.destination = nil
      expect(rule).not_to be_valid
    end

    it 'doesn\'t allow source col shorter than 5 characters' do
      rule.source = 'test'
      expect(rule).not_to be_valid
    end

    it 'doesn\'t allow special characters in source col' do
      rule.source = '@@test@@'
      expect(rule).not_to be_valid
    end

    it 'doesn\'t allow unsafe characters in destination col' do
      rule.destination = '/test/<>'
      expect(rule).not_to be_valid
    end

    it 'doesn\'t allow destination url in unallowed scheme' do
      rule.destination = 'ftp://ftp.naist.jp'
      expect(rule).not_to be_valid
    end
  end
end
