# frozen_string_literal: true

class RegistrationMailerPreview < ActionMailer::Preview
  def confirmation_email
    @user = User.new(
      id: 1,
      email: 'henk@hoogle.nom',
      first_name: 'Arie',
      last_name: 'De Bruijn'
    )

    RegistrationMailer.with(user: @user).confirmation_email
  end
end
