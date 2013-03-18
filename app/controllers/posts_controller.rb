class PostsController < ApplicationController
  before_filter :authenticate_admin!, :only => [:new, :create, :edit, :upadte]
  def index
    @posts = Post.order_by_time.page(params[:page]).per(5)

    respond_to do |f|
      f.html
      f.json { render :json => @posts.map { |p| {:id => p.id, :title => p.title} }.to_json }
    end
  end

  def life
    @posts = Post.life.page(params[:page]).per(5)

    respond_to do |f|
      f.html { render action: :index }
      f.json { render :json => @posts.map { |p| {:id => p.id, :title => p.title} }.to_json }
    end
  end

  def tech
    @posts = Post.tech.page(params[:page]).per(5)

    respond_to do |f|
      f.html { render action: :index }
      f.json { render :json => @posts.map { |p| {:id => p.id, :title => p.title} }.to_json }
    end
  end

  def show
    @post = Post.find(params[:id])

    respond_to do |f|
      f.html
      f.json { render :json => @post.to_json }
    end
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
