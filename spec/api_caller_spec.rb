require 'spec_helper'

describe ApiCaller do
  let(:api_caller) { ApiCaller.new({subdomain: 'demo', 
                                    zone_id: '1234', 
                                    username: 'aupeo_user', 
                                    password: 'aupeo123'}) }
  subject { api_caller }

  context 'not authenticated' do

  end

  context 'authenticated' do
    before(:each) { api_caller.authenticate! }

    describe '(M1) AdsSetup request' do
      it 'gets the single setup Ad back' do
        puts subject.inspect
        VCR.use_cassette('ads_setup') do
          puts subject.get_ads_setup.class
  #        expect(subject.get_ads_setup.first).to eq(Ad)
        end
      end
    end

    describe '(M2) AdsDisplayStarted'

    describe '(M3) AdsSendReport'

    describe '(M4) AdsDisplayEnd'

    describe '(M5) AdsClicked'

    describe '(M6) AdsPreviewStarted'

    describe '(M7) PreviewClicked'

    describe '(M8) LikeClicked'

    describe '(M9) ShareClicked'
  end
end
