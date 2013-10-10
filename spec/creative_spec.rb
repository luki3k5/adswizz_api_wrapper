require 'spec_helper'

describe AdswizzApiWrapper::Creative do

  context "linear" do
    let(:creative_details) do
      CreativeDetails.new('2.05', [], [] )
    end

    describe "#creation" do
      let(:creative) { AdswizzApiWrapper::Creative.new(creative_details, :linear)}

      it 'has duration setup' do
        expect(creative.duration).to eq('2.05')
      end
    end
  end

  protected
  CreativeDetails = Struct.new(:duration,
                               :mediafiles,
                               :tracking_urls)
end
