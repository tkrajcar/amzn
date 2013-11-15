require 'bitly'

class AmazonURLGenerator
  def initialize(bitly_login, bitly_api_key, tag)
    Bitly.configure do |config|
      config.api_version = 3
      config.login = bitly_login
      config.api_key = bitly_api_key
    end
    @tag = tag
    @bitly_client = Bitly.client
  end

  def generate(asin)
    url = "http://www.amazon.com/exec/obidos/ASIN/#{asin}/#{@tag}"
    {asin: asin, url: url, short_url: @bitly_client.shorten(url).short_url}
  end
end