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
end