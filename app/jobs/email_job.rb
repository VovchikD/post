# frozen_string_literal: true

class EmailJob < ApplicationJob
  queue_as :default

  def perform
    unseen_comments = Comment.unseen_comments
    return if unseen_comments.empty?

    unique_users = unseen_comments.map(&:user).uniq
    unique_users.each do |user|
      CommentMailer.notify_user(user, unseen_comments).deliver_now
    end
    unseen_comments.each(&:seen_comments)
  end
end
