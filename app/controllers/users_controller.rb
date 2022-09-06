class UsersController < ApplicationController
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
          flash[:success] = "Welcome #{@user.name}!"
          redirect_to @user
        end
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@user, template: new_user_path)
          ], status: :unprocessable_entity
        end
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
