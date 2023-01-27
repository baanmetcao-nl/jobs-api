# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from JWT::VerificationError do 
    head :unauthorized
  end

  def current_user
    token = authentication_token

    return nil if token.nil?

    payload = Jwt.decode(token)

    return nil if payload.nil?

    @current_user = User.find(payload[:user_id])
    @current_user
  end

  private

  def authentication_token = request.headers['Authorization']&.split(' ')&.last
end
