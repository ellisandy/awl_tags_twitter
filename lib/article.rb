require 'nokogiri'
require 'open-uri'
require 'tweet'

# The Article class contains the links and tags for consumption by twitter
class Article
  attr_accessor :tweets
  attr_accessor :link, :tags

  # CSS tag to pull the tags strings
  TAG_CSS = '.tags a'

  def initialize(link)
    @link = link
    @tweets = []
  end

  # Recursively build and populate tweets. This will catch any errors which
  # are raised by Tweet#add and attempt to call it again
  def build_tweets # rubocop:disable Metrics/MethodLength
    tweet = Tweet.new(@link)
    @tags.each do |tag|
      begin
        tweet.add(tag)
      rescue Tweet::TagTooLong
        @tweets.push tweet
        raise StandardError if "#{tag} | #{@link}".length > 140
        tweet = Tweet.new(@link)
      end
    end
    @tweets.push tweet
  end

  def tweets
    @tweets.map(&:to_s)
  end

  # sets @tags by calling the url, then filtering the document to find the
  # tags.
  def retrieve_tags
    # get post
    doc = request_url
    @tags = filter_tags(doc)
    self
  end

  # Filters finds the link inside the .g-tag-box div, pulls the name, then makes
  # the resulting string uppercase.
  def filter_tags(doc)
    # Filter down and get the tags.
    @tags = doc.css(TAG_CSS).map(&:children).map(&:text)
  end

  # Opens @link, then parses using Nokogiri
  def request_url
    # Get all data
    Nokogiri::HTML(open(@link))
  end
end
