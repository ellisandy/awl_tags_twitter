require 'contracts'
require 'twitter'

# Establishes the Twitter client
class TwitterClient
  include Contracts::Core

  # Shortcut for contracts
  C = Contracts

  Contract Hash => nil
  def initialize(credentials)
    # @config = {
    # consumer_key: '7Jw0Oc7ZVO9NHY5Z5ieYB91Rs',
    # consumer_secret: 'hjKJVdd2ikwHdD8SMJjDQQOxxw8FmhI22s3oGXtR7u3OllcDqf',
    # access_token: '794719566966333440-dR7EPJfd6wR5Wc0nhSR1yGZfKmrqPpI',
    # access_token_secret: 'YWwWVFhRRx84NH2VxjyxnUIiyeT2tEZZiBb8wjQ72ARRX'
    # }
    @client = Twitter::REST::Client.new(credentials)
    fail 'Unable to load your credentials' unless @client.credentials?
  end

  Contract String => Twitter::Tweet
  # Wrapper for Twitter::Rest::Client.update with retries if too many requests
  def update(post)
    @client.update(post)
  rescue Twitter::Error::TooManyRequests => error
    # NOTE: Your process could go to sleep for up to 15 minutes but if you
    # retry any sooner, it will almost certainly fail with the same exception.
    sleep error.rate_limit.reset_in + 1
    retry
  end
end
