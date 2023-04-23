module Mutations
  class CreatePost < BaseMutation
    field :post, Types::PostType, null: true
    field :errors, [String], null: false
    field :success, Boolean, null: false

    argument :user_id, Integer, required: true
    argument :title, String, required: true
    argument :content, String, required: false

    def resolve(user_id:, title:, content:)
      post = Post.create(user_id: user_id,
                         title: title,
                         content: content)

      return {
        post: post,
        errors: post.errors.full_messages,
        success: post.persisted?
      }
    end
  end
end
