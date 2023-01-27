# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'is valid with valid attributes' do
    assert users(:shell).valid?
  end

  test '#email returns the active e-mail' do
    user = users(:shell)
    assert_equal('henk@shell.com', user.email)
  end

  test "#email returns the active e-mail also when there's a change request" do
    new_email = EmailAddress.create!(email: 'shell2@shell.com')

    user = users(:shell)
    user.user_email_addresses.create!(use: :change_request, email_address: new_email)

    assert_equal('henk@shell.com', user.email)
  end

  test '#name returns the combined first and last name' do
    assert_equal users(:shell).name, 'Henk De Boer'
  end
end
