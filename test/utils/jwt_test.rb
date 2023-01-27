# frozen_string_literal: true

require 'test_helper'

class JWTTest < ActiveSupport::TestCase
  SECRET_KEY = 'abcd1234'

  test '.encode returns a non-empty string' do
    payload = { user_id: 123, email: 'mail@hoogle.nom' }

    encoded = Jwt.encode(payload, secret_key: SECRET_KEY)

    refute encoded.nil?
    refute encoded.blank?
  end

  test '.decode returns a payload matching the original payload' do
    payload = { user_id: 123, email: 'mail@hoogle.nom' }

    encoded = Jwt.encode(payload, secret_key: SECRET_KEY)
    decoded = Jwt.decode(encoded, secret_key: SECRET_KEY)

    assert decoded[:user_id] == 123
    assert decoded[:email] == 'mail@hoogle.nom'
  end

  test 'returns a different string depending on the input' do
    payload_a = { user_id: 123, email: 'mail@hoogle.nom' }
    encoded_a = Jwt.encode(payload_a, secret_key: SECRET_KEY)

    payload_b = { user_id: 1234, email: 'mail@hoogle.noms' }
    encoded_b = Jwt.encode(payload_b, secret_key: SECRET_KEY)

    refute_equal(encoded_a, encoded_b)
  end

  test 'raises an error when the expiration is in the past' do
    payload = { user_id: 123, email: 'mail@hoogle.nom' }

    encoded = Jwt.encode(payload, secret_key: SECRET_KEY, exp: 1.day.ago)

    assert_raises(JWT::ExpiredSignature) { Jwt.decode(encoded, secret_key: SECRET_KEY) }
  end
end
