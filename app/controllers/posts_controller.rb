class PostsController < ApplicationController
  # using devise authentication.
  before_filter :authenticate_user!

  def index
    @posts = Post.all
    @post = Post.new

    # load current active post if it exist.
    @post_current_active = @post.current

    respond_to do |format|
      format.html
    end
  end

  def create
    @post = Post.new(params[:post])
    @post.parse_time

    respond_to do |format|
      if @post.save
        format.html {
          redirect_to(posts_url, :notice => 'Post was successfully created.')
        }
        format.js {
          # load current active post if it exist.
          @post_current_active = @post.current
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
        @post_current_active = @post.current
      }
    end
  end

  # define a vote that a user makes on each post.
  def update
    @post = Post.find(params[:id])
    Rails.logger.debug("date c" + @post.completed_at.to_s)
    Rails.logger.debug("date u" + @post.updated_at.to_s)
    @post.completed_task = params[:completed_task]

    respond_to do |format|
      if @post.save
        # refresh all post if the models was updated.
        @posts = Post.all
        format.html { redirect_to(posts_url, :notice => 'Post was successfully updated.') }
        format.js
      else
        format.html { redirect_to(posts_url) }
        format.js
      end
    end
  end

end
