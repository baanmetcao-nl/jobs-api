# frozen_string_literal: true

class Job < ApplicationRecord
  scope :active, -> { where('expires_at < now()') }
  scope :expired, -> { where('expires_at > now()') }
  scope :published, -> { where('published_at IS NOT null') }

  enum experience: { unspecified: 0, junior: 1, medior: 2, senior: 3 }
  enum status: { draft: 0, active: 1 }

  belongs_to :employer
  has_one :benefits, dependent: :destroy

  accepts_nested_attributes_for :benefits

  validates :position, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 100, maximum: 5_000 }
  validates :expires_at, presence: true
  validates :status, presence: true

  validate :expires_in_future?, on: :create

  def expires_in_future?
    return false if expires_at.nil?

    expires_at.future?
  end
end
