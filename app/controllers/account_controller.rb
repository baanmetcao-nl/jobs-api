# frozen_string_literal: true

class AccountController < ApplicationController
  before_action :authorize_account!

  def destroy
    if @current_user.nil?
      render_not_found
    elsif @current_user.destroy
      render_ok
    else
      render_internal_server_error
    end
  end

  def create
    email = EmailAddress.find_or_initialize_by(email_params)

    if email.user_email_address.present?
      return render json: { error: "email_taken" }, status: :unprocessable_entity
    end

    @user = User.new(user_params.except(:email))
    @user.user_email_addresses.build(email_address: email)
    
    if @user.save
      AccountMailer
        .with(user: @user)
        .confirmation_email
        .deliver_later

      head :no_content
    else
      return render_internal_server_error
    end
  end

  def confirm
    @user = GlobalID::Locator.locate_signed(params[:token], for: 'account_confirmation')

    if @user.nil?
      render json: { error: "user_not_found"}, status: :not_found
    else
      @user.activated_at = Time.zone.now
      @user.save!

      render 'account/confirm', status: :ok
    end
  end

  private

  def user_params
    params
      .require(:account)
      .permit(
        :first_name,
        :last_name,
        :email,
        :employer
      )
  end

  def email_params
    user_params.slice('email')
  end

  def authorize_account! = authorize! :account
end
