# frozen_string_literal: true

class SessionMailerPreview < ActionMailer::Preview
  def login_email
    @user = User.new(
      email: 'henk@hoogle.nom',
      first_name: 'Arie',
      last_name: 'De Bruijn'
    )

    SessionMailer.with(user: @user).login_email
  end
end
