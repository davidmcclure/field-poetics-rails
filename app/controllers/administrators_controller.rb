class AdministratorsController < ApplicationController

  def first
    @administrator = Administrator.new
    @title = "Welcome"
    render :layout => 'welcome'
  end

  def create
    @administrator = Administrator.new(params[:administrator])
    if @administrator.save
      # login in
      redirect_to root_path
    else
      @title = "Welcome"
      render 'first', :layout => 'welcome'
    end
  end

end
