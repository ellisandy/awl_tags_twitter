require 'scraper'

RSpec.describe Scraper do
  context '#retrieve_posts' do
    let(:scraper) { Scraper.new }

    it 'responsed' do
      expect(scraper).to respond_to(:retrieve_posts)
    end

    it 'returns an arrays', :vcr do
      expect(scraper.retrieve_posts).to be_kind_of(Array)
    end

    it 'returns array with strings', :vcr do
      expect(scraper.retrieve_posts.first).to be_instance_of(Article)
    end

    it 'returns array with strings', :vcr do
      expect(scraper.retrieve_posts.first.link).to match(%r{^http:\/\/www\.theawl\.com\/\?p=[0-9]{6}$})
    end
  end

  context '#posts' do
    it { should respond_to(:articles) }
  end

  context '#create_articles' do
    let(:feed) { Scraper.new }
    url = 'http://domain.com'
    links = [url]

    it 'takes one arguement' do
      expect { feed.create_articles(links) }.not_to raise_error
    end
    it 'fails without an arguement' do
      expect { feed.create_articles }.to raise_error(ArgumentError)
    end
    it 'returns a new Artcile object' do
      expect(feed.create_articles(links).first).to be_kind_of(Article)
    end
    it 'has link' do
      expect(feed.create_articles(links).first.link).to be_kind_of(String)
    end
  end
end
