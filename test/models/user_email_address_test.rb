# frozen_string_literal: true

require 'test_helper'

class UserEmailAddressTest < ActiveSupport::TestCase
  test 'is valid with valid attributes' do
    assert user_email_addresses(:shell).valid?
  end

  test '#email delegates to email address' do
    assert 'henk@shell.com', user_email_addresses(:shell).email
  end
end
