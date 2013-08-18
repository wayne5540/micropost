class TheMicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  def index
  end

  def create
  	@the_micropost = current_user.the_microposts.build(the_micropost_params)
  	if @the_micropost.save
  		flash[:success] = "Micropost created!"
  		redirect_to root_url
  	else
  		@feed_items = []
      render 'static_pages/home'
  	end
  end

  def destroy
    @the_micropost.destroy
    redirect_to root_url
  end

  private

	  def the_micropost_params
	  	params.require(:the_micropost).permit(:content)
	  end

    def correct_user
      @the_micropost = current_user.the_microposts.find_by(id: params[:id])
      redirect_to root_url if @the_micropost.nil?
    end



end


