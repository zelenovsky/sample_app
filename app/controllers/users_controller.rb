class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
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
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update(user_params)
        format.html do
          flash[:success] = "Profile updated"
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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # hooks

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless me?(@user)
  end
end
