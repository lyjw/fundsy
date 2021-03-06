class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit([:first_name, :last_name, :email, :password, :address])
    @user = User.new user_params

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created!"
    else
      flash[:alert] = "Invalid parameters. Account was not created."
      render :new
    end
  end

end
