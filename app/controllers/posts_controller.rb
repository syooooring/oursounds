class PostsController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(8)
    
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
    if @post.user.id == current_user.id 
    else
      redirect_to root_path
    end
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

  def bass
    @posts = Post.where(pert: "ベース")
  end

  def keyboard
    @posts = Post.where(pert: "ピアノ・キーボード")
  end

  def guiter
    @posts = Post.where(pert: "ギター")
  end

  def vocal
    @posts = Post.where(pert: "ボーカル")
  end

   private

   def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

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