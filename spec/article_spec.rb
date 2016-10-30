require 'article'

RSpec.describe Article do
  let(:link) { 'https://medium.com/p/1fe66319e7e0' }
  let(:article) { Article.new(link) }
  context '#initialize' do
    it 'should raise ArgumentError' do
      expect { Article.new }.to raise_error(ArgumentError)
    end

    it 'should not raise any errors' do
      expect { article }.not_to raise_error
    end
  end

  context '#tags' do
    it 'should set @tags', :vcr do
      article.retrieve_tags
      expect(article.tags).to be_kind_of(Array)
    end

    it 'expects link to be set' do
      expect(article.link).to eq(link)
    end
  end

  context '#retrieve_tags' do
    it 'should set @tags', :vcr do
      expect(article.retrieve_tags).to be_truthy
    end

    it 'expects link to be set' do
      expect(article.link).to eq(link)
    end
  end

  context '#filter_tags' do
    it 'should raise error without arguement' do
      expect { article.filter_tags }.to raise_error(ArgumentError)
    end

    it 'should not raise an error with an arguement', :vcr do
      doc = article.request_url
      expect { article.filter_tags(doc) }.not_to raise_error
    end

    it 'returns array', :vcr do
      doc = article.request_url
      expect(article.filter_tags(doc)).to be_kind_of(Array)
    end
  end

  context '#request_url' do
    it 'returns doc', :vcr do
      expect(article.request_url).to be_kind_of(Nokogiri::HTML::Document)
    end
  end

  context '#build_tweets', :vcr do
    let(:link) { 'http://domain.com' }

    before do
      article.tags = tags
      article.link = link
    end

    context 'when there is only a few tags' do
      let(:tags) { ['foo'] }

      it 'returns an array of tweets' do
        expect(article.build_tweets.first.post).to eq("#{tags.first} | #{link}")
      end
      it 'returns only one tweet' do
        expect(article.build_tweets.count).to eq(1)
      end
    end

    context 'when there are a lot of tags' do
      let(:tags) { ['foo'] * 40 }

      it 'returns more than 1 tweet' do
        expect(article.build_tweets.count).to be > 1
      end
    end
  end

  context '#tweets' do
    let(:article) { Article.new(link) }
    let(:link) { 'http://domain.com' }
    let(:tags) { ['foo'] }

    before do
      article.tags = tags
      article.link = link
    end

    context 'when there are tweets' do
      it 'returns the array of tweets' do
        article.build_tweets

        expect(article.tweets).to eq(["#{tags.first} | #{link}"])
      end
    end
  end
end
