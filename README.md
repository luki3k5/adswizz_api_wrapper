# AdswizzApiWrapper

AdsWizz is infrastructure provider for serving Audio, Video, Text Ads.
They have a robust HTTP API which this gem wrapps up to allow accessing
it easier and save the development time.

## Installation

Add this line to your application's Gemfile:

    gem 'adswizz_api_wrapper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install adswizz_api_wrapper

## Usage

### Quering AdsExchange

Get the subdomain and zone_id from the AdsWizz. 
Create ApiCaller object in the following way:

    AdswizzApiWrapper::ApiCaller.new({
      :subdomain => 'exchange',
      :zone_id => '3031'
    }).adex_get_ads_setup

the above code gets you back array of AdswizzApiWrapper::Ad objects.

### Quering directly setup zone

    AdswizzApiWrapper::ApiCaller.new({
      :subdomain => 'your_subdomain',
      :zone_id => '1234'
    }).get_ads_setup

### Passing extra parameters to AdsServer

    AdswizzApiWrapper::ApiCaller.new({
      :subdomain     => 'demo_subdomain',
      :zone_id       => '1234',
      :extra_options => {
        :region         => "Deutschland", 
        :user           => 11,
        :user_language  => "german",
        :client_app_key => "1234xyz"
      }
    })

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

