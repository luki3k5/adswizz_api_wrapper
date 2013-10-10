require 'spec_helper'

describe ApiCaller do
  let(:api_caller) { ApiCaller.new({subdomain: 'demo',
                                    zone_id: '2409',
                                    username: 'aupeo_user',
                                    password: 'aupeo123'}) }
  subject { api_caller }

  describe '(M1) AdsSetup request', vcr: { cassette_name: 'api_calls/m1-ads-setup' } do
    it 'gets [Ad] class back' do
      expect(subject.get_ads_setup.first.class).to eq(Ad)
    end

    it 'has one Ad setup (test Ad)' do
      expect(subject.get_ads_setup.size).to eq(1)
    end

    describe 'returned Ad' do
      subject { api_caller.get_ads_setup.first }

      it 'has AdTitle' do
        expect(subject.ad_title).to eq('Ad One')
      end

      it 'has AdSystem' do
        expect(subject.ad_system).to eq('Adswizz')
      end

      it 'has LinearCreatives' do
        expect(subject.linear_creatives.class).to eq(Array)
        expect(subject.linear_creatives.first.class).to eq(Creative)
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
