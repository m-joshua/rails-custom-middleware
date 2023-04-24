class PostController < ApplicationController
  def edit
    @post = Post.find_by(id: params[:id])
  end
end
