require 'awl_tags_twitter'

RSpec.describe AwlTagsTwitter do
  context '#list' do
    it { should respond_to(:list) }

    it 'returns Array', :vcr do
      expect(AwlTagsTwitter.list).to be_kind_of(Array)
    end

    it 'returns Array of Articles', :vcr do
      expect(AwlTagsTwitter.list.first).to be_kind_of(Article)
    end
  end
end
