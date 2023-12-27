# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def destroy?
    user.admin? || record.user == user
  end
end
