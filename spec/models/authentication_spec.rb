require 'rails_helper'

RSpec.describe Authentication, type: :model do
  describe 'バリデーションチェック' do
    let(:user) { FactoryBot.create(:user)}

    it 'providerとuidの組み合わせが重複している場合は無効' do
      originally = FactoryBot.create(:authentication, user: user)
      duplicate = FactoryBot.build(:authentication, user: user)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors.full_messages).to include("Providerはすでに存在します")
    end
  end

  describe 'アソシエーションチェック' do
    it 'userとの関連が定義されているか' do
      should belong_to(:user)
    end
  end
end
