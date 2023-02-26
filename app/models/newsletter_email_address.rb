# frozen_string_literal: true

class NewsletterEmailAddress < ApplicationRecord
  belongs_to :email_address, dependent: :destroy
end
