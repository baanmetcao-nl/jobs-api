# frozen_string_literal: true

class SessionController < ApplicationController
  def show; end

  def create
    user = EmailAddress.find_by(email: session_params)&.user

    if user.nil?
      head :not_found
    else
      SessionMailer
        .with(user: user)
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
      # set current user
    end
  end

  def destroy; end

  private

  def session_params
    params.require(:email)
  end
end
