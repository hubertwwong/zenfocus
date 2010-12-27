class PostsController < ApplicationController

  def index
    @posts = Post.all
    @post = Post.new

    # load current active post if it exist.
    @post_current_active = @post.current_active?

    respond_to do |format|
      format.html
    end
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html {
          redirect_to(posts_url, :notice => 'Post was successfully created.')
        }
        format.js {
          # load current active post if it exist.
          @post_current_active = @post.current_active?
        }
      else
        format.html { redirect_to(posts_url) }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.js {
        # load current active post if it exist.
        @post_current_active = @post.current_active?
      }
    end
  end
  
end
