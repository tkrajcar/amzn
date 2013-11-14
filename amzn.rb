require 'bundler/setup'
require 'sinatra'
require 'bitly'

configure do
  set :tag, ENV["AMAZON_AFFILIATE_TAG"] || "CHANGE-ME"
  set :bitly_login, ENV["BITLY_LOGIN"] || "INVALID"
  set :bitly_api_key, ENV["BITLY_API_KEY"] || "INVALID"
end

Bitly.configure do |config|
  config.api_version = 3
  config.login = settings.bitly_login
  config.api_key = settings.bitly_api_key
end

bitly_client = Bitly.client

get '/' do
  haml :form
end

post '/' do
  raise NoURLProvided, 'Need to provide a URL, sucka!' unless url = params[:post]['url']
  raise NoASINFound, "Sorry, an ASIN couldn't be extracted from #{url}" unless  asin_array = url.match(/\/([A-Z0-9]{10})/)
  @asin = asin_array.captures.first
  @new_url = "http://www.amazon.com/exec/obidos/ASIN/#{@asin}/#{settings.tag}"
  @short_url = bitly_client.shorten(@new_url).short_url
  haml :results
end

class NoASINFound < StandardError; end
class NoURLProvided < StandardError; end