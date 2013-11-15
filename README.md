# amzn
A simple Sinatra application designed to help you quickly generate shortened (example: http://amzn.to/HTgg1c) Amazon product links with your affiliate tag. Exposes both a simple webform and an API.

Designed to be hosted on [Heroku](http://www.heroku.com/).

## Setting up on Heroku
Assuming you already have a Heroku account set up and the Heroku tools installed, you need a [bit.ly](bit.ly) account.

1. Clone this repo - `git clone git@github.com:tkrajcar/amzn.git amzn && cd amzn`
2. Create the Heroku app - `heroku create my-amzn`
3. Push the code - `git push heroku master`
4. Configure your affiliate tag - `heroku config:set AMAZON_AFFILIATE_TAG=mytag-20`
5. Configure your bit.ly username - `heroku config:set BITLY_LOGIN=mylogin`
6. Configure your bit.ly [api key](https://bitly.com/a/your_api_key) - `heroku config:set BITLY_API_KEY=abcde12345`
7. Use and enjoy - `heroku open`
