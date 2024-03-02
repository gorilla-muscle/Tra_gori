require 'rails_helper'

RSpec.describe UsersIllustration, type: :model do
  describe 'バリデーションチェック' do
    let(:user) { FactoryBot.create(:user) }
    let(:illustration) { FactoryBot.create(:illustration) }

    it 'user_idとillustration_idの組み合わせが重複している場合は無効' do
      originally = UsersIllustration.create(user: user, illustration: illustration)
      duplicate = UsersIllustration.new(user: user, illustration: illustration)
      expect(duplicate).not_to be_valid
      expect(duplicate.errors.full_messages).to include("Userはすでに存在します")
    end
  end

  describe 'アソシエーションチェック' do
    it 'userとの関連が定義されているか' do
      should belong_to(:user)
    end

    it 'illustrationとの関連が定義されているか' do
      should belong_to(:illustration)
    end
  end
end
