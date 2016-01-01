require 'awl_tags_twitter'

RSpec.describe AwlTagsTwitter do
  context '#list' do
    it { should respond_to(:list) }
  end
end
