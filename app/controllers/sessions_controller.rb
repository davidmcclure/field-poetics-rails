class SessionsController < ApplicationController

  def new
    @title = "Sign In"
    render :layout => 'welcome'
  end

  def create
    administrator = Administrator.authenticate(params[:administrator][:username], params[:administrator][:password])
    if administrator.nil?
      @title = "Sign In"
      render 'new', :layout => 'welcome'
    else
      sign_in administrator
      redirect_to root_path
    end
  end

  def destroy
  end

end
