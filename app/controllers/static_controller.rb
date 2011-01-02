class StaticController < ApplicationController

  def about
    respond_to do |format|
      format.html
    end
  end

  def help
    respond_to do |format|
      format.html
    end
  end

  def index
    if user_signed_in?
      redirect_to :controller => "posts"
    else
      respond_to do |format|
        format.html
      end
    end
  end
  
end
