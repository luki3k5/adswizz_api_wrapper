require 'spec_helper'

describe AdswizzApiWrapper::ApiCaller do
  let(:api_caller) { 
    AdswizzApiWrapper::ApiCaller.new({
      :subdomain => 'demo',
      :zone_id => '2409'
    })
  }

  let(:api_caller_for_ad_exchange) {
    AdswizzApiWrapper::ApiCaller.new({
      :subdomain => 'exchange',
      :zone_id => '3031'
    })
  }

  let(:api_caller_with_extra_options) { 
    AdswizzApiWrapper::ApiCaller.new({
      :subdomain     => 'demo',
      :zone_id       => '2409',
      :extra_options => {
        :region         => "Deutschland",
        :user           => 11,
        :user_language  => "german",
        :client_app_key => "1234xyz"
      }
    })
  }

  context 'ad exchange call w/o extra params' do
    subject { api_caller_for_ad_exchange }

    describe '(M1) AdsSetup request', :vcr => { :cassette_name => 'api_calls/m1-ads-setup-adex' }   do
    #describe '(M1) AdsSetup request' do
      it 'gets [Ad] class back' do
    #    VCR.turned_off do
    #      WebMock.allow_net_connect!
          expect(subject.adex_get_ads_setup.first.class).to eq(AdswizzApiWrapper::Ad)
    #    end
      end
    end
  end

  context 'with extra options' do
    subject { api_caller_with_extra_options }

    describe "setting up url" do
      it 'has extra params' do
        expect(subject.build_uri).
          to eq("http://demo.adswizz.com/www/delivery/swfIndex.php?reqType=AdsSetup&protocolVersion=2.0&zoneId=2409&AWPARAMS=region:Deutschland;user:11;user_language:german;client_app_key:1234xyz;")
      end
    end
  end

  context 'without extra options' do
    subject { api_caller }

    describe '(M1) AdsSetup request', :vcr => { :cassette_name => 'api_calls/m1-ads-setup' } do
      it 'gets [Ad] class back' do
        expect(subject.get_ads_setup.first.class).to eq(AdswizzApiWrapper::Ad)
      end

      it 'created extra params' do
        options = { :param1 => 'value1', :param2 => 'value2' }
        expect(subject.extra_parameters(options)).
          to eq("AWPARAMS=param1:value1;param2:value2;")
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
          expect(subject.linear_creatives.first.class).
            to eq(AdswizzApiWrapper::Creative)
        end

        describe 'Ad has creatives' do
          subject { api_caller.get_ads_setup.first.linear_creatives.first }

          it 'of class Creative' do
            expect(subject.class).to eq(AdswizzApiWrapper::Creative)
          end

          it 'that has hash of tracking events' do
            expect(subject.tracking_urls.class).to eq(Hash)
          end

          it 'it has event-tracking-url for :start' do
            expect(subject.tracking_urls[:start][0].request_uri).
              to include("AdsSendReport&displayPercentage=0")
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

        describe 'Ad has creative that has mediafiles' do
          let!(:creative) { api_caller.get_ads_setup.first.linear_creatives.first }
          subject { creative.media_files.first }

          it 'Creative has mediafiles' do
            expect(subject.class).to eq(AdswizzApiWrapper::MediaFile)
          end

          it 'MF has url' do
            expect(subject.url.request_uri).
              to eq("/demo/maid_with_the_flaxen_hair_ad_522986bc37c9c_1378453180.mp3")
          end

          it 'MF has type' do
            expect(subject.type).to eq("audio/mpeg")
          end

          it 'MF has delivery' do
            expect(subject.delivery).to eq("progressive")
          end

          it 'MF has bitrate' do
            expect(subject.bitrate).to eq(192)
          end

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
