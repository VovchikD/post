# frozen_string_literal: true

class PostCreation
  def initialize(user, post_params)
    @user = user
    @post_params = post_params
  end

  def self.call(user, post_params)
    new(user, post_params)
  end

  def call
    post = Post.new(@post_params.merge(user: @user))
    return post if post.save

    false
  end
end
