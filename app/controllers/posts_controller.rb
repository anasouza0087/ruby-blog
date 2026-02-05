
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  protect_from_forgery with: :null_session

def index
  Rails.logger.info "PARAMS 👉 #{params.to_unsafe_h}"

  posts = Post.all.order(id: :desc)

  if params[:id].present?
    posts = posts.where(id: params[:id])
  elsif params[:theme].present?
    posts = posts.where(theme: params[:theme])
  end

  render json: posts
end

def show
    render json: @post
end

def new
    @post = Post.new
end

def create
  @post = Post.new(post_params)

  if @post.save
    render json: @post, status: :created
  else
    render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
  end
end


def edit; end

def update
  if(@post.update(post_params))
    render json: @post
  else
    render json: { errors: @post.errors }, status: :unprocessable_entity
  end
end

def destroy
  @post.destroy
  head :no_content
end


private

def set_post
  @post = Post.find(params[:id])
end

def post_params
  params.require(:post).permit(:title, :text, :user, :theme)
  end
end
