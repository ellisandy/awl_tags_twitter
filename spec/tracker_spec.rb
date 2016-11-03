require 'tracker'

RSpec.describe Tracker do
  let(:tracker) { Tracker.new }
  let(:data) { '{ "articles" : [ "https://domain.com/123456" ] }' }

  before do
    allow(File).to receive(:read).and_return(data)
  end

  context '#articles' do
    context 'when the file is populated' do
      it 'returns an array with urls' do
        expect(tracker.articles).to eq(['https://domain.com/123456'])
      end
    end

    context 'when the file does not contain JSON' do
      let(:data) { ' { "articles": "blah" : "foo" } ' }

      before do
        expect(File).to receive(:read).and_return(data)
      end

      it 'returns an empty array' do
        expect(tracker.articles).to eq([])
      end
    end

    context 'when the file does not exist' do
      let(:data) { '{ "articles": [] }' }

      before do
        expect(File).to receive(:read).once.and_raise(Errno::ENOENT)
      end

      it 'returns an empty array' do
        expect(tracker.articles).to eq([])
      end
    end
  end

  context '#read_articles' do
    it 'returns an array of articles' do
      expect(tracker.read_articles).to eq(['https://domain.com/123456'])
    end
  end

  context '#write_articles' do
    it { is_expected.to respond_to(:write_articles) }

    context 'when the JSON is valid' do
      let(:article) { 'https://domain.com/123456' }

      it 'it writes the JSON to file' do
        tracker.articles << article
        tracker.write_articles
        expect(tracker.read_articles).to eq([article])
      end
    end
  end
end
