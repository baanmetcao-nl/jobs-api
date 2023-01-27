# frozen_string_literal: true

class RegistrationController < ApplicationController
  def create
    @user = User.new(user_params.except(:email))
    @user.user_email_addresses.build(email_address_attributes: email_params)

    if @user.save

      RegistrationMailer
        .with(user: @user)
        .confirmation_email
        .deliver_later

      head :no_content
    else
      head :unprocessable_entity
    end
  end

  def confirm
    @user = GlobalID::Locator.locate_signed(params[:token], for: 'registration_confirmation')

    if @user.nil?
      head :not_found
    else
      @user.activated_at = Time.zone.now
      @user.save!
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(
        :first_name,
        :last_name,
        :email
      )
  end

  def email_params
    user_params.slice('email')
  end
end
