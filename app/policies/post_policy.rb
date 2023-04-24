class PostPolicy < ApplicationPolicy
  def edit?
    post = Post.find_by(id: @record[:id]) # @record contains the params
    return false if @user.blank? || post.blank?

    post.user_id == @user.id
  end
end
