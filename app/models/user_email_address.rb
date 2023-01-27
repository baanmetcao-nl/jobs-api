# frozen_string_literal: true

class UserEmailAddress < ApplicationRecord
  belongs_to :user, dependent: :delete
  belongs_to :email_address, dependent: :delete

  accepts_nested_attributes_for :email_address

  enum use: { main: 0, change_request: 1 }
  delegate :email, to: :email_address

  validates :use, presence: true, uniqueness: { scope: :user_id }
end
