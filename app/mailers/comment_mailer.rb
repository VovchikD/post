# frozen_string_literal: true

class CommentMailer < ApplicationMailer
  def new_comment(user, comment)
    @comment = comment
    mail(
      to: user.email,
      subject: 'New massege under your post'
    )
  end
end
