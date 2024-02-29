require 'rails_helper'

RSpec.describe NumberOfBanana, type: :model do
  describe 'アソシエーションチェック' do
    it 'userとの関連が定義されているか' do
      should belong_to(:user)
    end
  end
end
