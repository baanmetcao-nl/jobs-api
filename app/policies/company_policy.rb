# frozen_string_literal: true

class CompanyPolicy < ApplicationPolicy
  authorize :user, allow_nil: true

  def create? = user.type == "undetermined"

  def update? = user.employer? && user.company.id == record.id
end
