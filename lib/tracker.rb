require 'contracts'
require 'json'

# Track previous posts in ./tmp/articles.json
class Tracker
  include Contracts::Core

  attr_accessor :articles

  # Short cut for Contract
  C = Contracts

  Contract C::None => C::ArrayOf[String]
  # reads articles from the ./tmp/articles.json file
  def read_articles
    file = JSON.load(File.read("#{Dir.home}/.awl_articles.json"))
    @articles = file['articles']

  rescue JSON::ParserError
    @articles = []
  rescue Errno::ENOENT
    @articles = []
  end

  Contract C::None => C::Num
  # writes articles from the ./tmp/articles.json file
  def write_articles
    f = File.new("#{Dir.home}/.awl_articles.json", 'w')
    f.write "{ \"articles\": #{@articles} }"
  end
end
