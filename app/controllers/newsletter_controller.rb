
# frozen_string_literal: true

class NewsletterController < ApplicationController
    def subscribe 
        email = EmailAddress.find_or_create_by(email_params)

        return render_no_content if email&.newsletter_email_address

        email.create_newsletter_email_address

        render_no_content
    end

    def unsubscribe
    end

    def email_params 
        params.require(:subscription)
            .permit(:email)
    end
end