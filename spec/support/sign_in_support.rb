module SignInSupport
  def sign_in(user)
    visit root_path
    click_on('ログイン')
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    find('.login__hover').hover
    find('input[name="commit"]').click
  end
end
