require 'nokogiri'
require 'rss'
require 'article'

# Class for handling RSS feed to grab posts
class Scraper
  # Array of Hashes
  attr_reader :articles

  # Retrieve a list of posts and return array of short links
  def retrieve_posts
    # Get posts
    rss = RSS::Parser.parse(AwlTagsTwitter::AWL_RSS_URL)

    # Grab shortened URLs
    links = rss.items.map(&:guid).map(&:content)

    @articles = create_articles(links)
  end

  # creates a new Article object. DOES NOT PULL TAGS
  def create_articles(links)
    links.map { |link| Article.new(link) }
  end
end
