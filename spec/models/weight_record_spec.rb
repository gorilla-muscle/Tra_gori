require 'rails_helper'

RSpec.describe WeightRecord do
  describe 'アソシエーションチェック' do
    it 'userとの関連が定義されているか' do
      should belong_to(:user)
    end
  end

  describe 'カスタムメソッドチェック' do
    it 'weight_recordsからcreated_atが今日の日付のレコードを検索しているか' do
      user = FactoryBot.create(:user)
      weight_record = FactoryBot.create(:weight_record, user: user)
      expect(WeightRecord.weight_record_for_day(user)).to eq weight_record
    end
  end
end
