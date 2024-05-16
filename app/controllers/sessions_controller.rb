# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login,:create]
  def create
    @user = User.find_by(username: params[:username])
    if !!@user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      message = 'Something went wrong! Make sure your username and password are correct.'
      redirect_to login_path, notice: message
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
