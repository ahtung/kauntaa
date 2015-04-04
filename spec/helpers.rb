# Helpers
module Helpers
  def omniauth_hash(email, password)
    OmniAuth::AuthHash.new(
      provider: 'google',
      uid: '1337',
      info: {
        email: email,
        password: password
      }
    )
  end

  def login_as(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end
end
