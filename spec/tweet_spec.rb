require 'tweet'

RSpec.describe Tweet do
  let(:link) { 'https://someurl.com/' }
  let(:tweet) { Tweet.new(link) }

  context '#to_s' do
    it 'returns a string shorter than 140' do
      expect(tweet.to_s.length).to be < 140
    end
  end

  context '#add' do
    context 'when the tag + @post is < 140' do
      let(:tag) { 'foo' }
      it 'is added' do
        expect(tweet.add(tag)).to eq("#{tag} | #{link}")
      end
    end
    context 'when the tag + @post is > 140' do
      let(:tag) { 'a' * 140 }
      it 'is not added' do
        expect { tweet.add(tag) }.to raise_error Tweet::TagTooLong
      end
    end
  end
end
