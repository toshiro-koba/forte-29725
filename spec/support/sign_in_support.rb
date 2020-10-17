module SignInSupport
  def sign_in(user)
    visit root_path
    within 'header' do # スコープを絞る
      click_on('ログイン')
    end
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    find('.login__hover-action').hover
    find('input[name="commit"]').click
  end
end
