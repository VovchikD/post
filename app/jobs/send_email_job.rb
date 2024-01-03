# frozen_string_literal: true

class SendEmailJob < ApplicationJob
  queue_as :default

  def perform
    unseen_comments = Comment.unseen.includes(:user)
    return if unseen_comments.empty?

    unseen_comments.group_by(&:user).each do |user, comments|
      CommentMailer.new_comment_notification(user, comments).deliver_later
    end
    unseen_comments.each(&:mark_seen)
  end
end
