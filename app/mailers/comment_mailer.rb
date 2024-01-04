# frozen_string_literal: true

class CommentMailer < ApplicationMailer
  def new_comment(user, comment)
    @comment = comment
    mail(
      to: user.email,
      subject: 'New massege under your post'
    )
  end

  def new_comment_notification(user, _comments)
    @comments = Comment.where(seen: false)
    mail(to: user.email, subject: "New Comment Notification - #{@comments.size} new comments") unless @comments.empty?
  end
end
