# frozen_string_literal: true

class Employer < ApplicationRecord
  belongs_to :company
  belongs_to :user

  has_many :jobs, dependent: :destroy
end
