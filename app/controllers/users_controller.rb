class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:show,:edit,:update]

  def show
    find_user
  end

  def edit
    find_user
  end

  def update
    find_user
    if params[:user][:password] == ""
      @user.update(update_params)
      if @user.errors.present?
        flash[error] = @user.errors.full_messages
        redirect_to :back and return
      end
    else
      @user.update(update_params_with_password)
      if @user.errors.present?
        flash[error] = @user.errors.full_messages
        redirect_to :back and return
      end
      redirect_to '/users/sign_in' and return
    end
    redirect_to :root, notice: "Profile updated"
  end


  private

  def find_user
    @user = User.find(params[:id])
  end

  def update_params
    params.require(:user).permit(:email, :f_name, :l_name, :profile, :avatar, :birthday, :gender)
  end

  def update_params_with_password
    params.require(:user).permit(:email, :f_name, :l_name, :profile, :avatar, :birthday, :gender, :password , :password_confirmation)
  end

end
