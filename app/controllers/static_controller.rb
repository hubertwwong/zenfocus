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
  
end
