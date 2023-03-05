# frozen_string_literal: true

return if @user.nil?
employer = @user.employer
company = employer.company

json.id @user.id
json.email @user.email
json.first_name @user.first_name
json.last_name @user.last_name
json.status @user.status
json.type @user.type

return unless company.present?

json.employer_id employer.id

json.company do 
    json.id company.id
    json.name company.name
    json.location company.location
    json.website_url company.website_url
    json.description company.description
end

