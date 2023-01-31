class NewsletterEmailAddress < ApplicationRecord
    belongs_to :email_address, dependent: :destroy
end
