# frozen_string_literal: true

json.id job.id
json.position job.position
json.description job.description
json.status job.status
json.experience job.experience
json.published_at job.published_at
json.expires_at job.expires_at

json.employer do
  json.id job.employer.id
  json.company do
    json.id job.employer.company.id
    json.location job.employer.company.location
    json.website_url job.employer.company.website_url
  end
end

json.benefits do
  json.min_salary job.benefits.min_salary
  json.max_salary job.benefits.max_salary
  json.vacation_days job.benefits.vacation_days
  json.pension job.benefits.pension
end
