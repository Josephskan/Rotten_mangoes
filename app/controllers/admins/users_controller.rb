class Admins::UsersController < ApplicationController

  before_filter :user_admin?
  before_filter :find_user, only: [:edit, :show, :update, :destroy]

  def index
    @users = User.page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admins_users_path, notice: "user #{@user.full_name} was added"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update 
    if @user.update_attributes(user_params)
      redirect_to admins_users_path, notice: "edits to user #{@user.lastname} completed"
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admins_users_path, notice: "account was sucesfully deleted"
  end

  def switch_view
    session[:cache] = current_user.id
    session[:user_id] = params[:user_id]
    # current_user = User.find(params[:user_id])
    redirect_to movies_path, notice: "you are now the user"
  end

  protected

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
