require 'bundler/setup'
require 'sinatra'
require 'require_all'
require_all 'lib'

configure do
  set :tag, ENV["AMAZON_AFFILIATE_TAG"] || "CHANGE-ME"
  set :bitly_login, ENV["BITLY_LOGIN"] || "INVALID"
  set :bitly_api_key, ENV["BITLY_API_KEY"] || "INVALID"
  set :generator,  AmazonURLGenerator.new(settings.bitly_login, settings.bitly_api_key, settings.tag)
end

get '/' do
  haml :form
end

post '/' do
  @results = parse_and_generate(params[:post]['url'])
  haml :results
end

get '/api.?:format?' do
  params[:format] ||= "txt"
  @results = parse_and_generate(params[:url])
  case params[:format].downcase
    when "txt"
      content_type :txt
      @results[:short_url]
    when "json"
      content_type :json
      @results.to_json
    else
      "Invalid format specified - try txt or json"
  end
end

def parse_and_generate(url)
  raise NoURLProvidedError, 'Need to provide a URL, sucka!' unless url
  raise NoASINFoundError, "Sorry, an ASIN couldn't be extracted from #{url}" unless asin = ASINExtractor.extract(url)
  settings.generator.generate(asin)
end

helpers do
  def facebook_share(url)
    "<a href='http://www.facebook.com/sharer.php?u=#{URI.encode(url)}' target='_blank'>Share on Facebook</a>"
  end

  def twitter_share(url)
    "<a href='https://www.twitter.com/share?url=#{URI.encode(url)}' target='_blank'>Tweet</a>"
  end
end