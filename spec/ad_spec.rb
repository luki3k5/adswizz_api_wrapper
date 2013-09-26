require 'spec_helper'

describe Ad do
  describe 'creation' do
    it 'raises error when none vast object is passed' do
      expect{Ad.new("somestring")}.to raise_error("Expected VAST::InlineAd class!") 
    end
  end
end
