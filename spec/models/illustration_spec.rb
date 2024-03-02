require 'rails_helper'

RSpec.describe Illustration do
  describe 'アソシエーションチェック' do
    it 'users_illustrationsとの関連が定義されているか' do
      should have_many(:users_illustrations).dependent(:destroy)
    end

    it 'usersとの関連が定義されているか' do
      should have_many(:users).through(:users_illustrations)
    end
  end
end
