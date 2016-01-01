require 'scraper'

RSpec.describe Scraper do
  context '#Version' do
    it 'has a version' do
      expect(Scraper::VERSION).to be_kind_of(String)
    end
  end
end
