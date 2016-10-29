require 'awl_tags_twitter/version'
require 'scraper'

# Default module -- using it as a controller
module AwlTagsTwitter
  # The Awl RSS feed URL
  AWL_RSS_URL = 'http://feeds2.feedburner.com/TheAwl'

  # Controller for list
  def list
    # Get content
    feed = Scraper.new
    feed.retrieve_posts

    # Output content to array of hashes
    # feed.articles.map { |article| article.retrieve_tags }
  end

  module_function :list
end
