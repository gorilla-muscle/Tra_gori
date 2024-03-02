# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    context '有効' do
      it '必要な情報が全て入力されている場合は成功' do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end

    context '無効' do
      it '名前が入力されていない場合は無効' do
        user = FactoryBot.build(:user, name: nil)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("名前を入力してください")
      end

      it '名前が1文字の場合は無効' do
        user = FactoryBot.build(:user, name: 'A')
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("名前は2文字以上で入力してください")
      end

      it '名前が50文字を超える場合は無効' do
        user = FactoryBot.build(:user, name: 'A' * 51)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("名前は50文字以内で入力してください")
      end

      it 'メールアドレスが入力されていない場合は無効' do
        user = FactoryBot.build(:user, email: nil)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it '重複したメールアドレスの場合は無効' do
        FactoryBot.create(:user)
        user = FactoryBot.build(:user, email: 'test@example.com')
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("メールアドレスはすでに存在します")
      end

      it 'パスワードが5文字以下の場合は無効' do
        user = FactoryBot.build(:user, password: 'A123')
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("パスワードは5文字以上で入力してください")
      end

      it 'パスワードが英字を含んでいない場合は無効' do
        user = FactoryBot.build(:user, password: '12345')
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'パスワードが数字を含んでいない場合は無効' do
        user = FactoryBot.build(:user, password: 'ABCDE')
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it '確認用パスワードが入力されていない場合は無効' do
        user = FactoryBot.build(:user, password_confirmation: nil)
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("確認用パスワードを入力してください")
      end
    end
  end
  
  describe 'アソシエーションチェック' do
    it 'authenticationsとの関連が定義されているか' do
      should have_many(:authentications).dependent(:destroy)
    end

    it 'training_recordsとの関連が定義されているか' do
      should have_many(:training_records).dependent(:destroy)
    end

    it 'users_illustrationsとの関連が定義されているか' do
      should have_many(:users_illustrations).dependent(:destroy)
    end

    it 'illustrationsとの関連が定義されているか' do
      should have_many(:illustrations).through(:users_illustrations)
    end

    it 'weight_recordsとの関連が定義されているか' do
      should have_many(:weight_records).dependent(:destroy)
    end

    it 'users_profileとの関連が定義されているか' do
      should have_one(:users_profile).dependent(:destroy)
    end

    it 'number_of_bananaとの関連が定義されているか' do
      should have_one(:number_of_banana).dependent(:destroy)
    end
  end

  describe 'カスタムメソッドチェック' do
    let(:user) { FactoryBot.create(:user, :with_authentications) }

    context 'バナナ所持数の増減関連' do
      # ユーザーのバナナ初期所持数が5本のため、初期値5でセットアップ
      before { user.create_number_of_banana!(count: 5) }

      it 'バナナの所持数が正確に1増加されるか' do
        expect { user.increment_banana_count }.to change { user.number_of_banana.count }.by(1)
      end

      it 'バナナの所持数が正確に5減少されるか' do
        expect { user.decrement_banana_count }.to change { user.number_of_banana.count }.by(-5)
      end
    end

    context '外部プロバイダー関連' do
      it 'プロバイダー名"google"をチェック出来ているか' do
        expect(user.google_check).to eq true
      end

      it 'プロバイダー名"line"をチェック出来ているか' do
        expect(user.line_check).to eq true
      end
    end
  end
end
