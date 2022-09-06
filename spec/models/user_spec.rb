RSpec.describe User do
  let(:user) { described_class.new(name: 'Example User', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar') }

  it 'should be valid' do
    expect(user).to be_valid
  end

  describe 'name' do
    it 'should be present' do
      user.name = '      '
      expect(user).to_not be_valid
    end

    it 'should not be too long' do
      user.name = 'a' * 51
      expect(user).to_not be_valid
    end
  end

  describe 'email' do
    it 'should be present' do
      user.email = '      '
      expect(user).to_not be_valid
    end

    it 'should not be too long' do
      user.email = 'a' * 244 + '@example.com'
      expect(user).to_not be_valid
    end

    it 'should be valid' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to_not be_valid
      end
    end

    it 'should be unique' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).to_not be_valid
    end
  end
  
  describe 'password' do
    it 'should be present' do
      user.password = user.password_confirmation = ' ' * 6
      expect(user).to_not be_valid
    end

    it 'should have a minimum length' do
      user.password = user.password_confirmation = 'a' * 5
      expect(user).to_not be_valid
    end
  end
end
