class GraphqlPolicy < ApplicationPolicy

  def update_post?
    return false if @user.blank? # unauthenticated
    post = Post.find_by(id: @record.dig("input", "postId"))
    return false if post.blank?

    post.user_id == @user.id
  end
end
