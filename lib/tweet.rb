require 'contracts'
require 'tweet/tag_too_long'

# Building a post to tweet
class Tweet
  include Contracts::Core

  attr_accessor :link
  attr_accessor :post

  # Shortcut for Contracts
  C = Contracts

  Contract String => String
  def initialize(link)
    @link = link
    @post = @link
  end

  Contract String => String
  # Add tag to @post
  def add(tag)
    temp_post = "#{tag} | #{@post}"
    if temp_post.length <= 140
      @post = tag + ' | ' + @post
    else
      fail Tweet::TagTooLong
    end
  end

  Contract C::None => String
  # Output the post
  def to_s
    @post.to_s
  end
end
