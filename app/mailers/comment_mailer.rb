# frozen_string_literal: true

class CommentMailer < ApplicationMailer
  def new_comment(user, comment)
    @comment = comment
    mail(
      to: user.email,
      subject: 'New massege under your post'
    )
  end

  def unseen_comments_notification(user, comments)
    @comments = comments
    mail(to: user.email, subject: "New Comment Notification - #{@comments.size} new comments") unless @comments.empty?
  end
end
