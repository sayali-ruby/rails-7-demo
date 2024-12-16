module Api
  module V1
    class PostsController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        @posts = Post.all
        render json: @posts
      end

      def show
        @post = Post.find(params[:id])
        render json: @post
      end

      def create
        @post = Post.new (posts_params)
        if @post.save
          render json: { "message": "Post created Successfully", post: @post }
        else
          render json: { "message": "Unable to create post" }
        end
      end

      def update
        @post = Post.find_by(id: params[:id])
        if @post.update(posts_params)
          render json: @post # {"message": "Post updated Successfully", post: @post}
        else
          render json: { "message": "Unable to update post" }
        end
      end

      def destroy
        @post = Post.find_by(id: params[:id])
        if @post.destroy
          render json: { "message": "Post deleted Successfully" }
        else
          render json: { "message": "Unable to destroy post with id #{params[:id]}" }
        end
      end

      private

      def posts_params
        params.require(:post).permit(:title, :description)
      end
    end
  end
end
