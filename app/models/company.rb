# frozen_string_literal: true

class Company < ApplicationRecord
  has_one :employer, dependent: :destroy
  has_many :jobs, through: :employer

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :location, presence: true, length: { minimum: 5, maximum: 50 }
  validates :website_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }
  validates :description, presence: true, length: { minimum: 20, maximum: 5_000 }

  has_one_attached :logo
end
