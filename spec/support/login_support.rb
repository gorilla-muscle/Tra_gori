module LoginSupport
  def login(user)
    visit login_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'A123456789'
    click_button 'ログイン'
  end
end