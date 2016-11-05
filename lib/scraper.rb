require 'article'
require 'contracts'
require 'nokogiri'
require 'rss'
require 'tracker'

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

  Contract C::None => C::ArrayOf[Article]
  # Subtrack saved artciles from the list of articles
  def subtract_cache
    tracker = Tracker.new
    tracker.read_articles
    @articles.delete_if { |x| tracker.articles.include?(x.link) }
  end
end
