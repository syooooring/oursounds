class PostsController < ApplicationController

  def index
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(10)
    
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  def search
    @posts = Post.where(post_search_params)
  end

  def drums
    @posts = Post.where(pert: "ドラム")
  end


   private

  def post_search_params
    p = params.permit(:type, :area, :day, :course, :style, :pert, :genre, :music)
    p.select{|key,value| value != ""}
    
    # selected = {}
    # p.each{|k,v|
    #   selected[k] = v if v != ""
    # }
    # return selected
  end

  def post_params
    params.require(:post).permit( :type, :area, :day, :course, :style, :pert, :genre, :music, :sound, :title, :text).merge(user_id: current_user.id)
  end
end