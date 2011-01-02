class PostsController < ApplicationController
  # using devise authentication.
  before_filter :authenticate_user!

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
  
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post,
                      :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors,
                      :status => :unprocessable_entity }
      end
    end
  end

end
