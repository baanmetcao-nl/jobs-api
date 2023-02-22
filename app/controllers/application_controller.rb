# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionPolicy::Controller

  verify_authorized

  authorize :user, through: :current_user

  rescue_from JWT::VerificationError do
    head :unauthorized
  end

  def current_user
    return @current_user if defined?(@current_user)

    token = authentication_token

    return nil if token.nil?

    payload = Jwt.decode(token)

    return nil if payload.nil?

    return nil if payload.fetch(:user_id, nil).nil?

    @current_user = User.find(payload[:user_id])
    @current_user
  end

  def render_unprocessable_entity
    render json: { error: 'Could not save the record' }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { error: 'Could not find the record' }, status: :not_found
  end

  def render_internal_server_error
    render json: { error: 'Internal server error' }, status: :internal_server_error
  end

  def render_no_content
    head :no_content
  end

  private

  def authentication_token = request.headers['Authorization']&.split(' ')&.last
end
