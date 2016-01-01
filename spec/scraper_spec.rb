require 'scraper'

RSpec.describe Scraper do
  context '#get_posts' do
    it { should respond_to(:get_posts) }
    it { should respond_to(:posts) }
  end
end
