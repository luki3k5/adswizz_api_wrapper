require 'spec_helper'

describe AdswizzApiWrapper::Ad do
  describe 'creation' do
    it 'raises error when none vast object is passed' do
      expect{AdswizzApiWrapper::Ad.new("somestring")}.to raise_error("Expected VAST::InlineAd class!") 
    end
  end
end
