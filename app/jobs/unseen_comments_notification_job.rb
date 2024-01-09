# frozen_string_literal: true

class UnseenCommentsNotificationJob < ApplicationJob
  queue_as :default

  def perform
    User.includes(:comments).where(comments: { seen: false }).find_each do |user|
      CommentMailer.unseen_comments_notification(user.id).deliver_later
      user.comments.unseen.update_all(seen: true)
    end
  end
end
