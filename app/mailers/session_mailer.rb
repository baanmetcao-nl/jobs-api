# frozen_string_literal: true

class SessionMailer < ApplicationMailer
  def login_email
    @user = params[:user]
    @token = @user.to_sgid(expires_in: 30.minutes, for: 'login_confirmation')
    @url = session_confirm_url(@token)

    mail(
      to: email_address_with_name(@user.email, @user.name),
      subject: 'Inloggen bij baanmetcao.nl'
    )
  end
end
