class PostsController < ApplicationController
  def index
    @posts =Post.all
      respond_to do |format|
        format.html # Renders the default `index.html.erb` template
        format.json { render json: @posts }
  end
  end

  def show
    @post =Post.find(params[:id])
  end

  def new
    @post =Post.new
  end

  def edit
    @post =Post.find(params[:id])
  end

  def update
     @post =Post.find(params[:id])
     if @post.update(post_params)
      redirect_to post_path(@post)
     else
      render :edit
     end
  end

  def create
    @post =Post.new(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def destroy
    @post =Post.find(params[:id])
    if @post.delete
      flash[:notice] = "Post deleted"
      redirect_to posts_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
