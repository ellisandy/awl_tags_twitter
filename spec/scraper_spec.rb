require 'scraper'

RSpec.describe Scraper do
  let(:scraper) { Scraper.new }

  context '#retrieve_posts' do
    it 'responsed', :vcr do
      expect(scraper).to respond_to(:retrieve_posts)
    end

    it 'returns an arrays', :vcr do
      expect(scraper.retrieve_posts).to be_kind_of(Array)
    end

    it 'returns array with strings', :vcr do
      expect(scraper.retrieve_posts.first).to be_instance_of(Article)
    end

    it 'returns array with strings', :vcr do
      expect(scraper.retrieve_posts.first.link).to be_instance_of(String)
    end
  end

  context '#articles' do
    it { should respond_to(:articles) }
  end

  context '#subtract_cache' do
    let(:article_1) { Article.new('http://domain.com/1') }
    let(:article_2) { Article.new('http://domain.com/2') }
    let(:double) { ['foo'] }

    context 'when there are previous articles' do
      before do
        allow_any_instance_of(Tracker).to receive(:articles).and_return(['http://domain.com/1'])
      end

      it 'does not return the previous articles', :vcr do
        scraper.instance_variable_set(:@articles, [article_1, article_2])
        scraper.subtract_cache
        expect(scraper.articles.map(&:link)).to eq(['http://domain.com/2'])
      end
    end

    context 'when there are no previous posts' do
      before do
        allow_any_instance_of(Tracker).to receive(:articles).and_return([])
      end

      it 'returns all posts' do
        scraper.instance_variable_set(:@articles, [article_1, article_2])
        scraper.subtract_cache
        expect(scraper.articles.map(&:link)).to eq(['http://domain.com/1', 'http://domain.com/2'])
      end
    end
  end
end
