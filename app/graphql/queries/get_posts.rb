module Queries
  class GetPosts < Queries::BaseQuery
    # argument :user_id, ID, required: true
    type [Types::PostType], null: true

    def resolve
      Post.all
    end
  end
end
