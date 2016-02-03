class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
    else
      flash.now[:alert] = "Login failed" 
      render :new
    end
  end

  def return_admin
    user = session[:user_id] 
    session[:user_id] = session[:cache]
    session[:cache] = nil
    redirect_to admins_user_path(User.find(user)), notice: "returned to admin" 
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "Adios!"
  end
end