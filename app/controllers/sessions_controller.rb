class SessionsController < ApplicationController

  def new
    @title = "Sign In"
    render :layout => 'welcome'
  end

  def create
    administrator = Administrator.authenticate(params[:session][:username], params[:session][:password])
    if administrator.nil?
      # do errors
    else
      # sign in and redirect to home
    end
  end

  def destroy
  end

end
