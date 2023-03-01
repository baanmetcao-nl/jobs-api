# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

UserEmailAddress.delete_all
Benefits.delete_all
Job.delete_all
Employer.delete_all
Company.delete_all
User.delete_all
EmailAddress.delete_all

description = <<~HEREDOC
  Cras nec pretium nibh, cursus finibus elit.#{' '}
  Vestibulum rutrum velit ut nulla ultrices consectetur eget nec dui.#{' '}
  In gravida purus eget ligula finibus auctor.#{' '}
  Nullam sed urna vitae dolor pulvinar placerat vel at nisl.#{' '}
  Sed iaculis feugiat libero non lacinia. Nulla facilisi. Nam tristique gravida libero ut ullamcorper
HEREDOC

shell_company = Company.create!(name: 'Shell PLC', location: 'Groningen', website_url: 'https://www.shell.com',
                                description:)
shell_user = User.create!(first_name: 'Henk', last_name: 'De Boer')
shell_employer = Employer.create!(company: shell_company, user: shell_user)
shell_job = Job.create!(employer: shell_employer, position: 'Software Engineer', description:,
                        expires_at: 1.year.from_now)
Benefits.create!(job: shell_job, min_salary: 80_000, max_salary: 100_000, vacation_days: 30, pension: true)
shell_email = EmailAddress.create!(email: 'henk@shell.com')
UserEmailAddress.create!(user: shell_user, email_address: shell_email)

unilever_company = Company.create!(name: 'Unilever', location: 'Haarlem', website_url: 'https://www.unilever.com',
                                   description:)
unilever_user = User.create!(first_name: 'Antoinette', last_name: 'Van Duin')
unilever_employer = Employer.create!(company: unilever_company, user: unilever_user)
unilever_job = Job.create!(employer: unilever_employer, position: 'Marketing manager', description:,
                           expires_at: 1.year.from_now)
Benefits.create!(job: unilever_job, min_salary: 120_000, max_salary: 130_000, vacation_days: 28,
                 pension: true)
unilever_email = EmailAddress.create!(email: 'antoinette@unilever.com')
UserEmailAddress.create!(user: unilever_user, email_address: unilever_email)

asml_company = Company.create!(name: 'ASML', location: 'Eindhoven', website_url: 'https://www.asml.com', description:)
asml_user = User.create!(first_name: 'Chantal-Dirk', last_name: 'Paternotte')
asml_employer = Employer.create!(company: asml_company, user: asml_user)
asml_job = Job.create!(employer: asml_employer, position: 'Chip-machine operator', description:,
                       expires_at: 1.year.from_now)
Benefits.create!(job: asml_job, min_salary: 105_000, max_salary: 130_000, vacation_days: 28,
                 pension: true)
asml_email = EmailAddress.create!(email: 'antoinette@asml.com')
UserEmailAddress.create!(user: asml_user, email_address: asml_email)
