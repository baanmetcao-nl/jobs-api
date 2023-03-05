# frozen_string_literal: true

return if @user.nil?

json.id @user.id
json.email @user.email
json.first_name @user.first_name
json.last_name @user.last_name
json.status @user.status
json.type @user.type

employer = @user.employer
company = employer&.company

return unless company.present?

json.company do
  json.id company.id
  json.name company.name
  json.location company.location
  json.website_url company.website_url
  json.description company.description

  json.jobs company.jobs do |job|
    json.position job.position
    json.id job.id
    json.description job.description
    json.experience job.experience
    json.status job.status
    json.expires_at job.expires_at
    json.published_at job.published_at
  end
end
