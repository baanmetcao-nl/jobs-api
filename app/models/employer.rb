# frozen_string_literal: true

class Employer < ApplicationRecord
  belongs_to :company, dependent: :destroy
  belongs_to :user, dependent: :destroy

  has_many :jobs
end
