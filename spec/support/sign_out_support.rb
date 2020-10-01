module SignOutSupport
  def sign_out(user)
    visit root_path
    find(".more").hover
    find('.log-out').click
  end
end