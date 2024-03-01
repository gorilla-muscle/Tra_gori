require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ユーザー登録' do
    context '入力情報が正しい場合' do
      it 'ユーザー登録が成功すること' do
        visit new_user_path
        fill_in '名前', with: 'Test_name'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード', with: 'Testpassword123'
        fill_in '確認用パスワード', with: 'Testpassword123'
        click_button '登録'
        expect(page).to have_content 'ログインしたウホッ！'
        expect(current_path).to eq training_records_path
      end
    end

    context '入力情報に誤りがある場合' do
      it 'ユーザー登録が失敗すること' do
        visit new_user_path
        fill_in '名前', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in '確認用パスワード', with: ''
        click_button '登録'
        expect(page).to have_content '登録出来なかったウホ....'
        expect(current_path).to eq new_user_path
      end
    end
  end
end
