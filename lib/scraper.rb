require 'nokogiri'
require 'rss'
require 'article'
require 'contracts'

# Class for handling RSS feed to grab posts
class Scraper
  include Contracts::Core

  # Array of Hashes
  attr_reader :articles

  # URL to pull the initial feed
  AWL_RSS_URL = 'http://feeds2.feedburner.com/TheAwl'
  # Shortcut for contracts
  C = Contracts

  Contract C::None => C::ArrayOf[Article]
  # Retrieve a list of posts and return array of short links
  def retrieve_posts
    # Get posts
    rss = RSS::Parser.parse(AWL_RSS_URL)

    # Grab shortened URLs
    links = rss.items.map(&:guid).map(&:content)

    @articles = []

    links.each do |link|
      @articles << Article.new(link)
    end

    @articles.map(&:retrieve_tags)
  end
end
