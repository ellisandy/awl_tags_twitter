require 'nokogiri'
require 'rss'
require 'article'
require 'contracts'

# Class for handling RSS feed to grab posts
class Scraper
  include Contracts::Core

  # Array of Hashes
  attr_reader :articles

  C = Contracts

  # Retrieve a list of posts and return array of short links
  Contract C::None => C::ArrayOf[Article]
  def retrieve_posts
    # Get posts
    rss = RSS::Parser.parse(AwlTagsTwitter::AWL_RSS_URL)

    # Grab shortened URLs
    links = rss.items.map(&:guid).map(&:content)

    @articles = create_articles(links)
  end

  # creates a new Article object. DOES NOT PULL TAGS
  Contract C::ArrayOf[String] => C::ArrayOf[Article]
  def create_articles(links)
    links.map { |link| Article.new(link) }
  end
end
