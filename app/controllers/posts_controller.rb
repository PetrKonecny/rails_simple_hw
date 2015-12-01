class PostsController < ApplicationController
  def index
    @posts = Post.all.order(:updated_at).reverse_order
    @tags = Tag.all.order(:posts_count).reverse_order
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to action: "index"
    else
      render "new"
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to action: "index"
    else
      render "edit"
    end
  end

  def filter
    @tags = Tag.all
    @tag_name = params[:tag_name]
    @posts = Tag.find_by_name(@tag_name).posts
    render "index"
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to action: "index"
  end

  private

  def post_params
    params.require(:post).permit(:author, :title, :body, :tags_string)
  end
end
