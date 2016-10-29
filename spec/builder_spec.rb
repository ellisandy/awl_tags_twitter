require 'builder'
require 'article'
require 'scraper'
require 'awl_tags_twitter'


RSpec.describe Builder do
  # context '#split_tweets' do
  #   let(:article) { Article.new('http://www.theawl.com/?p=222231') }
  #   it 'should raise ArgumentError' do
  #     expect { Builder.split_tweets }.to raise_error(ArgumentError)
  #   end
  #
  #   it 'should not raise any errors', :vcr do
  #     article.retrieve_tags
  #     expect { Builder.split_tweets(article) }.not_to raise_error
  #   end
  # end
  #
  # context '#validate_size' do
  #   let(:article) { Article.new('http://www.theawl.com/?p=222231') }
  #
  #   it 'expects 1 arguement', :vcr do
  #     article.retrieve_tags
  #     expect { Builder.validate_size(article) }.not_to raise_error
  #   end
  #
  #   it 'does not split short tags' do
  #     allow(article).to receive(:tags).and_return(['The RSpec Book'])
  #     expect(Builder.validate_size(article).count).to eq(1)
  #   end
  #
  #   it 'splits long tags in two' do
  #     allow(article).to receive(:tags).and_return(['11' * 56])
  #     allow(article).to receive(:link).and_return('http://www.theawl.com/?p=222231')
  #
  #     tags = Builder.validate_size(article)
  #     expect(tags).to eq(2)
  #   end
  #
  #   it 'splits long tags in two' do
  #     allow(article).to receive(:tags).and_return(["#{'1 ' * 56}"])
  #     allow(article).to receive(:link).and_return('http://www.theawl.com/?p=222231')
  #     expect(Builder.validate_size(article)).to eq(2)
  #   end
  #   #
  #   # it 'adds ... to the end of the first' do
  #   #   allow(article).to receive(:tags).and_return(['1 ' * 56])
  #   #   allow(article).to receive(:link).and_return('http://www.theawl.com/?p=222231')
  #   #
  #   #   expect(Builder.validate_size(article).first).to match(/^.+\.\.\.$/)
  #   # end
  #   # it 'adds ... to the beginning of the second' do
  #   #   allow(article).to receive(:tags).and_return(['1 ' * 56])
  #   #   allow(article).to receive(:link).and_return('http://www.theawl.com/?p=222231')
  #   #
  #   #   expect(Builder.validate_size(article).first).to match(/^.+\.\.\.$/)
  #   # end
  #   it 'returns array of strings', :vcr do
  #     article.retrieve_tags
  #     expect(Builder.validate_size(article)).to be_kind_of(Array)
  #   end
  # end
  #
  # context '#prepend_ellipsis' do
  #   let(:article) { Article.new('http://www.theawl.com/?p=222231') }
  #
  #   it 'returns array' do
  #     expect(Builder.prepend_ellipsis(article.link, ['11'] * 56)).to be_kind_of(Array)
  #   end
  #
  #   it 'to return two objects in array' do
  #     expect(Builder.prepend_ellipsis(article.link, ['11'] * 56).count).to eq(2)
  #   end
  #
  #   it 'to return two objects in array' do
  #     expect(Builder.prepend_ellipsis(article.link, ['11'] * 56).first).to match(/^.+\.\.\.$/)
  #   end
  #
  #   it 'to return two objects in array' do
  #     expect(Builder.prepend_ellipsis(article.link, ['1 '] * 56).last).to match(/^\.\.\..+$/)
  #   end
  #
  #   it 'prepends ... to the tweet'
  #   it 'appends ... to the tweet'
  #   it 'joins to tweets into two'
  # end
  #
  context '#chunk_large_blobs' do
    it 'splits long tags with spaces in by number of spaces' do
      link = 'http://www.theawl.com/?p=222231'
      tags = ['1 ' * 56]

      expect(Builder.chunk_large_blobs(tags, link).first).to eq(['1'] * 56)
    end

    it 'splits long tags with out spaces in two' do
      link = 'http://www.theawl.com/?p=222231'
      tags = ['11' * 56]

      # 105 + | + ... + link.size
      # (105 + 7) / 2 = 56
      expect(Builder.chunk_large_blobs(tags, link).first).to eq(['1' * 105, '1' * 7])
    end
  end
  
  context '#rejoin_chunks' do
    it 'returns array of strings' do
      link = 'http://www.theawl.com/?p=222231'
      tags = [['1' * 105, '1' * 7], 'hello world']
      
      expect(Builder.rejoin_chunks(tags, link)).to eq(nil)
      
    end
  end
  context '#join_tweets' do
    let(:article) { Article.new('http://www.theawl.com/?p=222231') }

    it 'fail without arguements' do
      expect { Builder.join_tweets }.to raise_error(ArgumentError)
    end

    it 'expects two arguements' do
      expect { Builder.join_tweets(article, ['blah']) }.not_to raise_error
    end

    it 'sets the tweets on Article' do
      expect(Builder.join_tweets(article, ['tag one', 'tag two'])).to eq(['tag one|tag two|http://www.theawl.com/?p=222231'])
    end

    it 'will not create a tweet longer than 140 characters', :vcr do
      feed = Scraper.new
      feed.retrieve_posts

      feed.articles.map(&:retrieve_tags)

      feed.articles.each do |post|
        Builder.split_tweets(post)

        post.tweets.each do |tweet|
          if tweet.size >= 140
            puts tweet
          end
          expect(tweet.size).to be <= 140
        end
      end
    end
  end
  #
  # context '#add_link_to_tweet' do
  #   let(:article) { Article.new('http://www.theawl.com/?p=222231') }
  #
  #   it 'appends link to each tweet' do
  #     tweet = 'tag one|tag two|'
  #     Builder.add_link_to_tweet(article, tweet)
  #
  #     expect(tweet).to match(%r{^.+http:\/\/www\.theawl\.com\/\?p=222231$})
  #   end
  # end
end
