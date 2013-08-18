class StaticPagesController < ApplicationController
  def home
  	@the_micropost = current_user.the_microposts.build if signed_in?
    @feed_items = current_user.feed.paginate(page: params[:page]) if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  	
  end
end
