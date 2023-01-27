# frozen_string_literal: true

class Benefits < ApplicationRecord
  belongs_to :job, dependent: :destroy

  validates :min_salary, presence: true, numericality: { min: 10_000, max: 9_999_999 },
                         comparison: { less_than_or_equal_to: :max_salary }
  validates :max_salary, presence: true, numericality: { min: 10_000, max: 9_999_999 },
                         comparison: { greater_than_or_equal_to: :min_salary }
  validates :vacation_days, presence: true, numericality: { min: 15, max: 200 }
  validates :pension, presence: true, inclusion: { in: [true, false] }

  validate :valid_salary?

  def valid_salary? = max_salary >= min_salary
end
