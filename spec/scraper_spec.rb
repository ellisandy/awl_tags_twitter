require 'scraper'

RSpec.describe Scraper do
  context '#retrieve_posts' do
    let(:scraper) { Scraper.new }

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

  context '#posts' do
    it { should respond_to(:articles) }
  end
end
