require 'rails_helper'

RSpec.describe Katgut::Rule, type: :model do
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

    it 'doesn\'t allow destination url longer than 2083 characters' do
      rule.destination += 'a' * (2083 - rule.destination.length) + 'X'
      expect(rule).not_to be_valid
    end
  end

  describe "#regular_destination" do
    context 'the destination url has a scheme specification' do
      let(:rule) { build(:rule, destination: "https://httpbin.org/") }

      it 'returns the destination as is' do
        expect(rule.regular_destination).to eq "https://httpbin.org/"
      end
    end

    context 'the destination url begins with slash' do
      let(:rule) { build(:rule, destination: "/katgut_success.html") }

      it 'returns the destination as is' do
        expect(rule.regular_destination).to eq "/katgut_success.html"
      end
    end

    context 'the destination begins with number/alphabet character' do
      let(:rule) { build(:rule, destination: "httpbin.org/") }

      it 'assumes the scheme is http' do
        expect(rule.regular_destination).to eq "http://httpbin.org/"
      end
    end
  end

  describe '#set_random_source' do
    context 'the model is new and inialized without source url' do
      let(:rule) { Katgut::Rule.new }

      it 'generates a random source url automatically' do
        expect(rule.source).not_to eq nil
      end

      it 'generates at least 6 character length or longer url' do
        expect(rule.source.length).to be >= 6
      end
    end

    context 'the model is new and initialized with a source url' do
      let(:rule) { build(:rule, source: "osusume") }

      it 'keeps the given source and do nothing' do
        expect(rule.source).to eq "osusume"
      end
    end

    context 'the model is persisted and initialized from db' do
      before { create(:rule, source: "osusume") }

      it 'keeps the given source and do nothing' do
        expect(Katgut::Rule.last.source).to eq "osusume"
      end
    end
  end
end
