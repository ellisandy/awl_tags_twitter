# Build tags into separate tweets
module Builder
  module_function

  # STORY: Call split_tweets, This should break apart each of the elements

  # Split array into separate arrays into 140 (- the length of the link)
  def split_tweets(article)
    temp_tweets = validate_size(article)
    join_tweets(article, temp_tweets)
  end

  # validates that there are not tags longer than 139 - article.link.size
  def validate_size(article)
    temp_tweets = chunk_large_blobs(article.tags, article.link)
    rejoin_chunks(temp_tweets, article.link)
  end

  # Deconstruct long tags
  def chunk_large_blobs(tags, link)
    tags.map do |tag|
      split = tag.split(' ') if (tag.size >= 139 - link.size) && tag[' ']
      scanned = tag.scan(/.{1,#{136 - link.size}}/) if tag.size >= 135 - link.size
      split || scanned || tag
    end
  end

  # Should be able to rework this using map to reduce the complicated logic.
  def rejoin_chunks(tags, link)
    tweets = []
    tags.each do |tag|
      if tag.class == Array
        array = prepend_ellipsis(link, tag)
        tweets += array
      else
        tweets << tag
      end
    end
    tweets
  end

  def prepend_ellipsis(link, tags)
    proposed_tweet = ''
    tweets = []
    tags.each do |tag|
      if (proposed_tweet.size + link.size + tag.size + 4) >= 140
        tweets << "#{proposed_tweet.strip}..."
        proposed_tweet = "...#{tag} "
      else
        proposed_tweet << "#{tag} "
      end
    end
    tweets << proposed_tweet.strip
  end

  # Joins split tags together as tweets
  def join_tweets(article, temp_tweets)
    output = ''

    temp_tweets.each do |tweet|
      if (output.size + tweet.size + 1 + article.link.size) >= 140
        add_link_to_tweet(article, output)
        output = "#{tweet}|"
      else
        output << "#{tweet}|"
      end
    end
    add_link_to_tweet(article, output)
  end

  # Add append Link to the tweet, and save to Article#tweets
  def add_link_to_tweet(article, tweet)
    tweet << article.link
    article.tweets << tweet
  end
end
