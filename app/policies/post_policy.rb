# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user.admin? || record.user == user
  end
end
