require 'article'

RSpec.describe Article do
  link = 'https://medium.com/p/1fe66319e7e0'
  context '#initialize' do
    it 'should raise ArgumentError' do
      expect { Article.new }.to raise_error(ArgumentError)
    end

    it 'should not raise any errors' do
      expect { Article.new(link) }.not_to raise_error
    end
  end

  context '#tags' do
    let(:article) { Article.new(link) }
    it 'should set @tags', :vcr do
      article.retrieve_tags
      expect(article.tags).to be_kind_of(Array)
    end

    it 'expects link to be set' do
      expect(article.link).to eq(link)
    end
  end

  context '#retrieve_tags' do
    let(:article) { Article.new(link) }
    it 'should set @tags', :vcr do
      expect(article.retrieve_tags).to be_truthy
    end

    it 'expects link to be set' do
      expect(article.link).to eq(link)
    end
  end

  context 'filter_tags' do
    let(:article) { Article.new(link) }

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

  context 'request_url' do
    let(:article) { Article.new(link) }

    it 'returns doc', :vcr do
      expect(article.request_url).to be_kind_of(Nokogiri::HTML::Document)
    end
  end
end
