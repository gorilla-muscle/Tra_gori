require 'rails_helper'

RSpec.describe Authentication, type: :model do
  describe 'バリデーションチェック' do
    let(:user) { FactoryBot.create(:user)}

    it 'providerとuidの組み合わせが重複していない場合は有効' do
      FactoryBot.create(:authentication, user: user, provider: 'provider1', uid: 'test123')
      new_authentication = FactoryBot.build(:authentication, user: user, provider: 'provider2', uid: 'test456')
      expect(new_authentication).to be_valid
    end

    it 'providerとuidの組み合わせが重複している場合は無効' do
      FactoryBot.create(:authentication, user: user, provider: 'provider1', uid: 'test123')
      new_authentication = FactoryBot.build(:authentication, user: user, provider: 'provider1', uid: 'test123')
      expect(new_authentication).not_to be_valid
      expect(new_authentication.errors.full_messages).to include("Providerはすでに存在します")
    end
  end

  describe 'アソシエーションチェック' do
    it 'userとの関連が定義されているか' do
      should belong_to(:user)
    end
  end
end
