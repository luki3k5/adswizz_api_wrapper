require 'spec_helper'

describe ApiCaller do
  let(:api_caller) { ApiCaller.new({subdomain: 'demo', zone_id: '2409' }) }
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

      describe 'Ad has creatives' do
        subject { api_caller.get_ads_setup.first.linear_creatives.first }

        it 'that has hash of tracking events' do
          expect(subject.tracking_urls.class).to eq(Hash)
        end

        it 'it has event-tracking-url for :start' do
          expect(subject.tracking_urls[:start][0].request_uri).to eq("/www/delivery/swfIndex.php?reqType=AdsSendReport&displayPercentage=0&time=0&protocolVersion=2.0&adId=11421&zoneId=2409&viewKey=1381390933.96&tagsArray=&sessionId=1398ca87c86b674708e288a21d71b88c")
        end

        it 'it has event-tracking-url for :first_quartile' do
          expect(subject.tracking_urls[:first_quartile][0].request_uri).
            to include("AdsSendReport&displayPercentage=25")
        end

        it 'it has event-tracking-url for :midpoint' do
          expect(subject.tracking_urls[:midpoint][0].request_uri).
            to include("AdsSendReport&displayPercentage=50")
        end

        it 'it has event-tracking-url for :third_quartile' do
          expect(subject.tracking_urls[:third_quartile][0].request_uri).
            to include("AdsSendReport&displayPercentage=75")
        end

        it 'it has event-tracking-url for :complete' do
          expect(subject.tracking_urls[:complete][0].request_uri).
            to include("AdsDisplayEnd&displayPercentage=100")
        end
      end

      xit 'Ad has mediafiles (in creatives)' do
        expect(subject.linear_creatives.first.media_files).to eq("")
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
