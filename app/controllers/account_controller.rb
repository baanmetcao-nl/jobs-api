# frozen_string_literal: true

class AccountController < ApplicationController
  def destroy
    user = User.find(params[:id])
    if user.nil?
      render json: { error: 'User not found' }, status: :not_found
    elsif user.destroy
      head :no_content
    else
      head :internal_server_error
    end
  end

  def create
    @user = User.new(user_params.except(:email))
    @user.user_email_addresses.build(email_address_attributes: email_params)

    if @user.save
      AccountMailer
        .with(user: @user)
        .confirmation_email
        .deliver_later

      head :no_content
    else
      render json: { error: 'Could not save the user' }, status: :unprocessable_entity
    end
  end

  def confirm
    @user = GlobalID::Locator.locate_signed(params[:token], for: 'account_confirmation')

    if @user.nil?
      render json: { error: 'User not found' }, status: :not_found
    else
      @user.activated_at = Time.zone.now
      @user.save!

      render 'account/confirm', status: :ok
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
