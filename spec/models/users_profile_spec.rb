require 'rails_helper'

RSpec.describe UsersProfile, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe 'バリデーションチェック' do
    context '有効' do
      it 'target_weightの値が小数点第一位までで且つ30以上150以下の場合は有効' do
        target_weight = FactoryBot.build(:users_profile, user: user)
        expect(target_weight).to be_valid
      end
    end

    context '無効' do
      it 'target_weightの値が50未満の場合は無効' do
        target_weight = FactoryBot.build(:users_profile, user: user, target_weight: 29.0)
        expect(target_weight).not_to be_valid
        expect(target_weight.errors.full_messages).to include("目標体重は30より大きい値にしてください")
      end

      it 'target_weightの値が150を超える場合は無効' do
        target_weight = FactoryBot.build(:users_profile, user: user, target_weight: 151.0)
        expect(target_weight).not_to be_valid
        expect(target_weight.errors.full_messages).to include("目標体重は150より小さい値にしてください")
      end

      it 'target_weightの値が小数点第一位を超える場合は無効' do
        target_weight = FactoryBot.build(:users_profile, user: user, target_weight: 70.55)
        expect(target_weight).not_to be_valid
        expect(target_weight.errors.full_messages).to include("目標体重は小数点第一位まで入力して下さい")
      end
    end
  end

  describe 'アソシエーションチェック' do
    it 'userとの関連が定義されているか' do
      should belong_to(:user)
    end
  end
end
