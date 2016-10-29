require 'nokogiri'
require 'open-uri'

# The Article class contains the links and tags for consumption by twitter
class Article
  attr_accessor :tweets
  attr_reader :link, :tags

  # CSS tag to pull the tags strings
  TAG_CSS = '.tags a'

  def initialize(link)
    @link = link
    @tweets = []
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
