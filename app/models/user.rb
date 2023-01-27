# frozen_string_literal: true

class User < ApplicationRecord
  has_one :employer

  enum status: { draft: 0, active: 1, inactive: 2, banned: 3 }

  has_many :user_email_addresses
  has_many :email_addresses, through: :user_email_addresses

  accepts_nested_attributes_for :user_email_addresses

  validates :first_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :status, presence: true

  def name = "#{first_name} #{last_name}".strip

  def email = user_email_addresses.where(use: :main).first&.email

  def type
    return 'employer' if employer.present?

    'unknown'
  end
end
