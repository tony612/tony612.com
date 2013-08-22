class PostsController < ApplicationController
  respond_to :html, :json
  respond_to :atom, :rss, only: :index

  before_filter :authenticate_admin!, :only => [:new, :create, :edit, :upadte]

  def index
    @posts = Post.order_by_time.page(params[:page]).per(5)

    respond_with @posts
  end

  def life
    @posts = Post.life.page(params[:page]).per(5)

    respond_with @posts, action: :index
  end

  def tech
    @posts = Post.tech.page(params[:page]).per(5)

    respond_with @posts, action: :index
  end

  def show
    @post = Post.find(params[:id])

    respond_with @post
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
      params.require(:post).permit(:title, :content, :created_at, :category, :excerpt)
    end
end
