# frozen_string_literal: true

class UnseenCommentsNotificationJob < ApplicationJob
  queue_as :default

  def perform
    User.includes(:comments).where(comments: { seen: false }).distinct.each do |user|
      comments = user.comments.unseen.to_a
      CommentMailer.unseen_comments_notification(user, comments).deliver_later
      Comment.where(user_id: user.id, seen: false).update(seen: true)
    end
  end
end
