require 'bundler/setup'
require 'sinatra'
require 'require_all'
require_all 'lib'

configure do
  set :tag, ENV["AMAZON_AFFILIATE_TAG"] || "CHANGE-ME"
  set :bitly_login, ENV["BITLY_LOGIN"] || "INVALID"
  set :bitly_api_key, ENV["BITLY_API_KEY"] || "INVALID"
end

generator = AmazonURLGenerator.new(settings.bitly_login, settings.bitly_api_key, settings.tag)

get '/' do
  haml :form
end

post '/' do
  raise NoURLProvidedError, 'Need to provide a URL, sucka!' unless url = params[:post]['url']
  raise NoASINFoundError, "Sorry, an ASIN couldn't be extracted from #{url}" unless asin = ASINExtractor.extract(url)
  @results = generator.generate(asin)
  haml :results
end