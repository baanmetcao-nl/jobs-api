# frozen_string_literal: true

class SessionController < ApplicationController
  skip_verify_authorized only: %i[show create confirm]

  def show
    @user = current_user
  end

  def create
    user = EmailAddress.find_by(session_params)&.user

    if user.nil?
      head :not_found
    else
      SessionMailer
        .with(user:)
        .login_email
        .deliver_later

      head :no_content
    end
  end

  def confirm
    @user = GlobalID::Locator.locate_signed(params[:token], for: 'login_confirmation')

    if @user.nil?
      head :not_found
    else
      payload = { user_id: @user.id }
      response.headers['Authorization'] = "Bearer #{Jwt.encode(payload)}"
    end
  end

  private

  def session_params
    params.require(:session).permit(:email)
  end
end
