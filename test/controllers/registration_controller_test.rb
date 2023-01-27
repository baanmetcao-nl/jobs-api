# frozen_string_literal: true

require 'minitest/autorun'

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  test '#create returns no content' do
    post registration_url, params: {
      user: {
        email: 'mail@hoogle.nom',
        first_name: 'Bert',
        last_name: 'De Boer'
      }
    }

    assert_response :no_content
  end

  test '#create creates a new user' do
    assert_difference 'User.count', 1 do
      post registration_url, params: {
        user: {
          email: 'mail@hoogle.nom',
          first_name: 'Bert',
          last_name: 'De Boer'
        }
      }
    end
  end

  test '#create sents a confirmation email' do
    post registration_url, params: {
      user: {
        email: 'mail@hoogle.nom',
        first_name: 'Bert',
        last_name: 'De Boer'
      }
    }

    perform_enqueued_jobs

    mail = ActionMailer::Base.deliveries.last

    assert_equal mail.to.first, 'mail@hoogle.nom'
    assert mail.body.raw_source.include?('Bevestig je account bij baanmetcao.nl')
  end

  test '#create returns unprocessable entity when invalid' do
    post registration_url, params: {
      user: {
        email: 'mailhoogle.nom',
        first_name: 'Bert',
        last_name: 'De Boer'
      }
    }

    assert_response :unprocessable_entity
  end

  test '#confirm returns not found when the user is not found' do
    put registration_confirm_url('none-existing')

    assert_response :not_found
  end

  test '#confirm returns the user when the user is found' do
    user = users(:shell)
    token = user.to_sgid(expires_in: 7.days, for: 'registration_confirmation')
    put registration_confirm_url(token)

    assert_response :ok

    body = JSON.parse(@response.body)

    assert_equal body['email'], 'henk@shell.com'
    assert_equal body['first_name'], 'Henk'
    assert_equal body['last_name'], 'De Boer'
    assert_equal body['status'], 'draft'
    assert_equal body['type'], 'employer'
  end
end
