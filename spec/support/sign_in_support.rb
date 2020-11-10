module SignInSupport
  def sign_in(user)
    visit root_path
    click_on('ログイン')
    sleep 0.1
    fill_in 'メールアドレス', with: user.email
    sleep 0.1
    fill_in 'パスワード', with: user.password
    find('.login__hover').hover
    find('input[name="commit"]').click
  end
end
