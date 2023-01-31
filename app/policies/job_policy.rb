# frozen_string_literal: true

class JobPolicy < ApplicationPolicy
  alias_rule :publish, :unpublish, to: :update?
  authorize :user, allow_nil: true

  def index?  = true
  def create? = allowed?
  def update? = update_allowed?

  def allowed?
    return false if user.nil?
    return false unless user.active?
    return false unless user.activated?
    return false unless user.employer?

    record.employer.id == user.employer.id
  end

  def update_allowed?
    return false unless allowed?

    record.employer.id != user.employer.id
  end

  # See https://actionpolicy.evilmartians.io/#/writing_policies
  #
  # def index?
  #   true
  # end
  #
  # def update?
  #   # here we can access our context and record
  #   user.admin? || (user.id == record.user_id)
  # end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end
end
