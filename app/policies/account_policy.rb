
# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy
    authorize :user, allow_nil: true

    def destroy? = user.present?
    
    def create? = user.nil?

    def confirm? = true
end