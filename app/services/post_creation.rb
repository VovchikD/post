# frozen_string_literal: true

class PostCreation
  def initialize(user:, post_params:)
    @user = user
    @post_params = post_params
  end

  def self.call(user, post_params)
    new(user: user, post_params: post_params).call
  end

  def call
    post = Post.new(@post_params.merge(user: @user))
    if post.save
      true
    else
      false
    end
  end
end
