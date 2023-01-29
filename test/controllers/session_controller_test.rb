# frozen_string_literal: true

require 'minitest/autorun'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test '#create returns no content' do
    user = users(:shell)

    post session_url, params: {
      session:{
      email: user.email
      }
    }

    assert_response :no_content
  end

  test '#create sends an e-mail' do
    user = users(:shell)

    post session_url, params: {
session:{
      email: user.email
      }
    }

    perform_enqueued_jobs

    mail = ActionMailer::Base.deliveries.last

    assert_equal mail.to.first, 'henk@shell.com'
    assert mail.body.raw_source.include?('inloglink')
  end

  test '#create returns not found when the user is not found' do
    post session_url, params: {
      session: {
      email: 'mail@hoogle.nom'
      }
    }

    assert_response :not_found
  end

  test '#confirm returns not found when the user is not found' do
    put session_confirm_url('blaat'), params: {
      session: {
      email: 'mail@hoogle.nom'
      }
    }

    assert_response :not_found
  end

  test '#confirm returns the user' do
    user = users(:shell)
    token = user.to_sgid(expires_in: 30.minutes, for: 'login_confirmation')

    put session_confirm_url(token)

    assert_response :ok

    body = JSON.parse(@response.body)

    assert_equal 'henk@shell.com', body['email']
    assert_equal 'Henk', body['first_name']
    assert_equal 'De Boer', body['last_name']
    assert_equal 'draft', body['status']
    assert_equal 'employer', body['type']
  end
end
