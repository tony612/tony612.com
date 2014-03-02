require 'helper'

describe User do
  before(:each) do
    ENV['GITHUB_ADMIN_ID'] = "username:test@example.com"
  end
  after(:each) do
    ENV.delete('GITHUB_ADMIN_ID')
  end
  describe '.find_from_user_info' do
    it 'returns nil for param which is not an array' do
      expect(User.find_from_user_info(123)).to eql(nil)
      expect(User.find_from_user_info({})).to eql(nil)
    end
    it 'returns nil when passed nothing' do
      expect(User.find_from_user_info).to eql(nil)
    end
    it 'returns nil when user info is not right' do
      expect(User.find_from_user_info(["foo", "bar"])).to eql(nil)
    end
    it 'returns user_info when user info is right' do
      expect(User.find_from_user_info(["username", "test@example.com"])).to eql(["username", "test@example.com"])
    end
  end
end
