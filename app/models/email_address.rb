# frozen_string_literal: true

class EmailAddress < ApplicationRecord
  has_one :user_email_address, dependent: :destroy
  has_one :user, through: :user_email_address

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
