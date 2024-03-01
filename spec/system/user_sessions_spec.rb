require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { FactoryBot.create(:user) }

  describe 'ログイン処理' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功すること' do
        visit login_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'A123456789'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしたウホッ！'
        expect(current_path).to eq training_records_path
      end
    end

    context 'フォームの入力値に誤りがある' do
      it 'ログイン処理が失敗すること' do
        visit login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        click_button 'ログイン'
        expect(page).to have_content 'ログイン出来なかったウホ....'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログアウト処理' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功すること', js: true do
        page.driver.browser.manage.window.resize_to(1280, 800)
        login(user)
        accept_confirm do
          click_link 'ログアウト'
        end
        expect(page).to have_content 'ログアウトしたウホッ！'
        expect(current_path).to eq root_path
      end
    end
  end
end
