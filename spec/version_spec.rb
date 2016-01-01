require 'awl_tags_twitter/version'

RSpec.describe AwlTagsTwitter do
  context '#Version' do
    it 'has a version' do
      expect(AwlTagsTwitter::VERSION).to be_kind_of(String)
    end
  end
end
