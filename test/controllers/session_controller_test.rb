# frozen_string_literal: true

require 'minitest/autorun'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test '#create returns no content' do
    user = users(:shell)

    post session_url, params: {
      email: user.email
    }

    assert_response :no_content
  end

  test '#create sends an e-mail' do
    user = users(:shell)

    post session_url, params: {
      email: user.email
    }

    perform_enqueued_jobs

    mail = ActionMailer::Base.deliveries.last

    assert_equal mail.to.first, 'henk@shell.com'
    assert mail.body.raw_source.include?('inloglink')
  end

  test '#create returns not found when the user is not found' do
    post session_url, params: {
      email: 'mail@hoogle.nom'
    }

    assert_response :not_found
  end

  test '#confirm returns not found when the user is not found' do
    post session_url, params: {
      email: 'mail@hoogle.nom'
    }

    assert_response :not_found
  end

  test '#confirm returns the user' do
    user = users(:shell)
    token = user.to_sgid(expires_in: 30.minutes, for: 'login_confirmation')

    put session_confirm_url(token)

    assert_response :ok

    body = JSON.parse(@response.body)

    assert_equal body['email'], 'henk@shell.com'
    assert_equal body['first_name'], 'Henk'
    assert_equal body['last_name'], 'De Boer'
    assert_equal body['status'], 'draft'
    assert_equal body['type'], 'employer'
  end
end
