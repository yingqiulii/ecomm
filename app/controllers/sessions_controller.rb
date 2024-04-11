class SessionsController < ApplicationController
  def new

  end

  def create
    if customer=login(params[:email],params[:password])
      flash[:notice]="successful login"
      redirect_to root_path
    else
      flash[:notice]="try again"
      redirect_to new_session_path
    end
  end
end