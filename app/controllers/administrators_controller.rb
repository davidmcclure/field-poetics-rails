class AdministratorsController < ApplicationController

  def first
    @administrator = Administrator.new
    @title = "Welcome"
    render :layout => 'welcome'
  end

  def create
    @administrator = Administrator.new(params[:administrator])
    if @administrator.save
      sign_in @administrator
      redirect_to root_path
    else
      @title = "Welcome"
      render 'first', :layout => 'welcome'
    end
  end

end
