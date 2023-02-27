# frozen_string_literal: true

require 'minitest/autorun'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test '#create returns no content' do
    user = users(:shell)
    user.company.destroy!
    user.activate!

    post companies_url,
         headers: auth_headers(user.id),
         params: {
           company: {
            location: 'Groningen, FR',
             name: 'Hoogle.nom N.V.',
             description: 'lorem ipsum vero eos et accusamus et iusto odio dignissimos ducimus',
             website_url: 'https://www.hoogle.nom'
           }
         }

    assert_response :no_content
  end

  test '#create creates an employer' do
    user = users(:shell)
    user.company.destroy!
    user.activate!

    post companies_url,
         headers: auth_headers(user.id),
         params: {
           company: {
            location: 'Groningen, FR',
             name: 'Hoogle.nom N.V.',
             description: 'lorem ipsum vero eos et accusamus et iusto odio dignissimos ducimus',
             website_url: 'https://www.hoogle.nom'
           }
         }

    assert user.reload.employer.id.present?
  end

  test '#create creates a company' do
    user = users(:shell)
    user.company.destroy!
    user.activate!

    post companies_url,
         headers: auth_headers(user.id),
         params: {
           company: {
            location: 'Groningen, FR',
             name: 'Hoogle.nom N.V.',
             description: 'lorem ipsum vero eos et accusamus et iusto odio dignissimos ducimus',
             website_url: 'https://www.hoogle.nom'
           }
         }

    assert_equal 'Hoogle.nom N.V.', user.reload.company.name
  end

  test '#update returns no content' do
    user = users(:shell)

    put companies_url,
         headers: auth_headers(user.id),
         params: {
           company: {
            location: 'Groningen, FR',
             name: 'Hoogle.nom N.V.',
             description: 'lorem ipsum vero eos et accusamus et iusto odio dignissimos ducimus',
             website_url: 'https://www.hoogle.nom'
           }
         }

    assert_response :no_content
  end

  test '#update updates a company' do
    user = users(:shell)

    put companies_url,
         headers: auth_headers(user.id),
         params: {
           company: {
            location: 'Groningen, FR',
             name: 'Hoogle.nom N.V.',
             description: 'lorem ipsum vero eos et accusamus et iusto odio dignissimos ducimus',
             website_url: 'https://www.hoogle.nom'
           }
         }

    assert_equal 'Hoogle.nom N.V.', user.reload.company.name
  end
end
