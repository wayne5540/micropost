class UsersController < ApplicationController
  #let user access edit and update action only if they are signed in.
  before_action :sign_in_user, only: [:indes, :edit, :update, :deatroy]
  #let user change their own data only.
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  def show
  	@user = User.find(params[:id])
    @the_microposts = @user.the_microposts.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)  
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Microposts"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    #don't need to find user because the correct_user before filter defines @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile update"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


  private
  
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
