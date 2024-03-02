require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ユーザー登録処理' do
    context 'フォームの入力値が正常' do
      it '登録処理が成功すること' do
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

    context 'フォームの入力値に誤りがある' do
      it '登録処理が失敗すること' do
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
