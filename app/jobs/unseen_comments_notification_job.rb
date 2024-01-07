# frozen_string_literal: true

class UnseenCommentsNotificationJob < ApplicationJob
  queue_as :default

  def perform
    User.includes(:comments).where(comments: { seen: false }).distinct.each do |user|
      comments = user.comments.where(seen: false).to_a
      CommentMailer.notification_user_of_new_comments(user, comments).deliver_later
      Comment.where(user_id: user.id, seen: false).update(seen: true)
    end
  end
end
