module Mutations
  class UpdatePost < BaseMutation
    field :post, Types::PostType, null: true
    field :errors, [String], null: false
    field :success, Boolean, null: false

    argument :post_id, Integer, required: true
    argument :title, String, required: false
    argument :content, String, required: false

    def resolve(post_id:, title:, content:)
      data = {
        post: nil,
        errors: [],
        success: false
      }
      post = Post.find_by(id: post_id)
      if post.blank?
        data[:errors] << "Post not found!"
        return data
      end

      updated = post.update(title: title,content: content)

      return {
        post: post,
        errors: post.errors.full_messages,
        success: updated
      }
    end
  end
end
