RSpec.describe Micropost do
  let(:micropost) { create(:micropost) }
  let(:user_with_microposts) do
    create :user do |user|
      create_list :micropost, 5, user: user
    end
  end

  it 'should be valid' do
    expect(micropost).to be_valid
  end

  describe 'content' do
    it 'should be present' do
      micropost.content = '      '
      expect(micropost).not_to be_valid
    end

    it 'should be less than 140 symbols' do
      micropost.content = 'a' * 141
      expect(micropost).not_to be_valid
    end
  end

  specify 'order should be most recent first' do
    microposts = user_with_microposts.microposts
    expect(microposts.reorder(created_at: :desc)).to eq(microposts)
  end
end
