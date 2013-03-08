class PostsController < ApplicationController
  before_filter :authenticate_admin!, :only => [:new, :create, :edit, :upadte]
  def index
    @posts = Post.order("created_at DESC").page(params[:page]).per(5)
  end

  def life
    @posts = Post.order("created_at DESC").where(category: "life").page(params[:page]).per(5)
    render action: :index
  end

  def tech
    @posts = Post.order("created_at DESC").where(category: "tech").page(params[:page]).per(5)
    render action: :index
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render action: 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(post_params)
      redirect_to @post
    else
      render action: 'edit'
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :content, :created_at, :category)
    end
end
