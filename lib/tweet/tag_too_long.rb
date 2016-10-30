require 'tweet'

# Extending lib/tweet
class Tweet
  # Defining TagTooLong standard error
  class TagTooLong < StandardError
  end
end
