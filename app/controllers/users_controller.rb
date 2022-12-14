class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def show
    @user = User.find(params[:id])
    @pagy, @microposts = pagy(@user.microposts.all)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html do
          login(@user)
          remember(@user)
          flash[:success] = "Welcome #{@user.name}!"
          redirect_to @user
        end
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@user, partial: 'users/signup_form')
          ], status: :unprocessable_entity
        end
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @pagy, @users = pagy(User.all)
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(user_params)
        format.html do
          flash[:success] = 'Profile updated'
          redirect_to @user
        end
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@user, partial: 'users/edit_form')
          ], status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_path
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @pagy, @users = pagy(@user.following)
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @pagy, @users = pagy(@user.followers)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # hooks

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless me?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
