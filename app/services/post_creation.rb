# frozen_string_literal: true

class PostCreation
  def initialize(user, post_params)
    @user = user
    @post_params = post_params
  end

  def post_create
    post = Post.new(@post_params.merge(user: @user))
    return post if post.save

    false
  end
end
