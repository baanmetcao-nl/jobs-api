# frozen_string_literal: true

class RegistrationMailer < ApplicationMailer
  def confirmation_email
    @user = params[:user]
    @token = @user.to_sgid(expires_in: 7.days, for: 'registration_confirmation')
    @url = registration_confirm_url(@token)

    mail(
      to: email_address_with_name(@user.email, @user.name),
      subkect: 'Jouw registratie bij baanmetcao.nl'
    )
  end
end
