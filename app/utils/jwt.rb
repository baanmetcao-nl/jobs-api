# frozen_string_literal: true

module Jwt
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  module_function

  def encode(payload, exp: 24.hours.from_now, secret_key: SECRET_KEY, algorithm: 'HS256')
    JWT.encode(payload.merge(exp: exp.to_i), secret_key, algorithm)
  end

  def decode(token, secret_key: SECRET_KEY)
    decoded = JWT.decode(token, secret_key).first

    HashWithIndifferentAccess.new(decoded)
  end
end
