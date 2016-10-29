require 'nokogiri'
require 'open-uri'
require 'builder'

# The Article class contains the links and tags for consumption by twitter
class Article
  include Builder

  attr_accessor :tweets
  attr_reader :link, :tags

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
  end

  # Filters finds the link inside the .g-tag-box div, pulls the name, then makes
  # the resulting string uppercase.
  def filter_tags(doc)
    # Filter down and get the tags.
    @tags = doc.css('.g-tag-box ul li a').map(&:content).map(&:upcase)
  end

  # Opens @link, then parses using Nokogiri
  def request_url
    # Get all data
    Nokogiri::HTML(open(@link))
  end
end
