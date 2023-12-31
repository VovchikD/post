# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def destroy?
    user.admin? || record.user == user
  end
end
