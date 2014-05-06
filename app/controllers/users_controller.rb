class UsersController < ApplicationController

  def new
    @user = User.new    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to projects_path, notice: "You have signed up successfully"
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id]) 
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to projects_path, notice: "Profile has been updated."  
    else
      render 'edit'
    end
  end
  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
