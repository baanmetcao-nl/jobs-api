# frozen_string_literal: true

require 'minitest/autorun'

class JobsControllerTest < ActionDispatch::IntegrationTest
  test '#index returns a list of users' do
    get jobs_url

    assert_response :ok

    body = JSON.parse(@response.body)

    job_1 = body.first
    job_2 = body.second

    assert_equal 'Software Engineer', job_1['position']
    assert_equal 'draft', job_1['status']
    assert_equal 'senior', job_1['experience']
    assert_equal 1, job_1['employer']['id']
    assert_equal 10_000, job_1['benefits']['min_salary']
    assert_equal 100_000, job_1['benefits']['max_salary']
    assert_equal true, job_1['benefits']['pension']
    assert_equal 20, job_1['benefits']['vacation_days']

    assert_equal 'Chip Producing Engineer', job_2['position']
    assert_equal 'draft', job_2['status']
    assert_equal 'junior', job_2['experience']
    assert_equal 2, job_2['employer']['id']
    assert_equal 20_000, job_2['benefits']['min_salary']
    assert_equal 200_000, job_2['benefits']['max_salary']
    assert_equal true, job_2['benefits']['pension']
    assert_equal 40, job_2['benefits']['vacation_days']
  end

  test '#create saves a new job' do
    user = users(:shell)
    user.activate!

    post jobs_url,
         headers: auth_headers(user.id),
         params: job_create_params

    assert_response :no_content
  end

  test '#create raises unauthorized without an employer' do
    assert_raises ActionPolicy::Unauthorized do
      post jobs_url, params: job_create_params
    end
  end

  test '#update raises unauthorized for updating a job of another employer' do
    user = users(:asml)
    job = jobs(:shell)

    assert_raises ActionPolicy::Unauthorized do
      put job_url(job.id), params: {}, headers: auth_headers(user.id)
    end

    assert_raises ActionPolicy::Unauthorized do
      put job_publish_url(job.id), params: {}, headers: auth_headers(user.id)
    end

    assert_raises ActionPolicy::Unauthorized do
      put job_unpublish_url(job.id), params: {}, headers: auth_headers(user.id)
    end
  end

  private

  def job_create_params
    {
      job: {
        position: 'Patattenbakker',
        description: 'At vero eos et accusamus et iusto odio dignissimom. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus.',
        experience: 'senior',
        expires_at: 10.days.from_now,
        benefits: {
          min_salary: 100_000,
          max_salary: 120_000,
          pension: true,
          vacation_days: 33
        }
      }
    }
  end
end
